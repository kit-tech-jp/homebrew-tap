# Homebrew formula for kai
# Update version, URLs, and sha256 values when releasing a new version.
# Requires HOMEBREW_GITHUB_API_TOKEN for private repository access.

require_relative "lib/private_strategy"

class Kai < Formula
  desc "Local AI development assistant environment centered around Claude Code"
  homepage "https://github.com/kit-tech-jp/kit-ai"
  version "0.8.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/kit-tech-jp/kit-ai/releases/download/v#{version}/kai-darwin-arm64",
          using: ::GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "7bde7c17a2a13897ee4df0f1ce035ed9ae9a5f553d6da967e5f7de764b9de596"
    else
      url "https://github.com/kit-tech-jp/kit-ai/releases/download/v#{version}/kai-darwin-x64",
          using: ::GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "87d0238400caf4c340b5481b1afe060470199cafbdad566601fecf988f15dc34"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/kit-tech-jp/kit-ai/releases/download/v#{version}/kai-linux-arm64",
          using: ::GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "09732e5fb766e91c0dfaa80ba424b66e4821448fde6f55840918996a7ba970c1"
    else
      url "https://github.com/kit-tech-jp/kit-ai/releases/download/v#{version}/kai-linux-x64",
          using: ::GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "6ff7851b3989730013bffddfa9b72cb05b97844a016b9be5460e90ad3adec35d"
    end
  end

  def install
    binary_name = stable.url.split("/").last
    bin.install binary_name => "kai"
  end

  test do
    assert_match "kai v#{version}", shell_output("#{bin}/kai --version")
  end
end
