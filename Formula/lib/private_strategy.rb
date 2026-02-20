# Custom download strategy for private GitHub repository releases.
# Based on: https://gist.github.com/minamijoyo/3d8aa79085369efb79964ba45e24bb0e
#
# Requires HOMEBREW_GITHUB_API_TOKEN environment variable.

require "download_strategy"

class GitHubPrivateRepositoryReleaseDownloadStrategy < CurlDownloadStrategy
  def initialize(url, name, version, **meta)
    super
    parse_url_pattern
    set_github_token
  end

  def parse_url_pattern
    url_pattern = %r{https://github.com/([^/]+)/([^/]+)/releases/download/([^/]+)/(.+)}
    unless @url =~ url_pattern
      raise CurlDownloadStrategyError, "Invalid url pattern for GitHub Release."
    end

    _, @owner, @repo, @tag, @filename = *@url.match(url_pattern)
  end

  def set_github_token
    @github_token = ENV["HOMEBREW_GITHUB_API_TOKEN"]
    unless @github_token
      raise CurlDownloadStrategyError, "Environmental variable HOMEBREW_GITHUB_API_TOKEN is required."
    end
  end

  def download_url
    "https://#{@github_token}@api.github.com/repos/#{@owner}/#{@repo}/releases/assets/#{asset_id}"
  end

  def resolve_url_basename_time_file_size(url, timeout: nil)
    url = download_url
    super
  end

  def resolved_basename
    @filename
  end

  private

  def _fetch(url:, resolved_url:, timeout:)
    curl_download(
      download_url,
      "--header", "Accept: application/octet-stream",
      to: temporary_path
    )
  end

  def asset_id
    @asset_id ||= resolve_asset_id
  end

  def resolve_asset_id
    release_url = "https://api.github.com/repos/#{@owner}/#{@repo}/releases/tags/#{@tag}"
    response = curl_output(
      "--header", "Authorization: token #{@github_token}",
      "--header", "Accept: application/vnd.github.v3+json",
      release_url
    )

    release = JSON.parse(response.stdout)
    assets = release["assets"]
    raise CurlDownloadStrategyError, "No assets found for release #{@tag}" unless assets

    asset = assets.find { |a| a["name"] == @filename }
    raise CurlDownloadStrategyError, "Asset #{@filename} not found in release #{@tag}" unless asset

    asset["id"]
  end
end
