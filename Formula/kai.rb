# Homebrew formula for kai
# Update version, URLs, and sha256 values when releasing a new version.
# Requires HOMEBREW_GITHUB_API_TOKEN for private repository access.

require_relative "lib/private_strategy"

class Kai < Formula
  desc "Local AI development assistant environment centered around Claude Code"
  homepage "https://github.com/kit-tech-jp/kit-ai"
  version "0.14.10"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/kit-tech-jp/kit-ai/releases/download/v#{version}/kai-darwin-arm64",
          using: ::GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "2ae18fe0ebf37ae0ce3c365629252c7d78a3ba48b6a3230bd7badb8fa9d91b69"
    else
      url "https://github.com/kit-tech-jp/kit-ai/releases/download/v#{version}/kai-darwin-x64",
          using: ::GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "489353c494552af6ba15cf3c363d259778b6bea60a72053bace71964baf623db"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/kit-tech-jp/kit-ai/releases/download/v#{version}/kai-linux-arm64",
          using: ::GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "306f20697d4cf2bc995a0ee502c74e2f00f5f05fc4e599a003e65b1cf4d7e0d0"
    else
      url "https://github.com/kit-tech-jp/kit-ai/releases/download/v#{version}/kai-linux-x64",
          using: ::GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "8bb97f95b5256d35240612c2905f68265d8ae5b6122254c6ea288ae54f2c8ae1"
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
