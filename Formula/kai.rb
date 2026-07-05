# Homebrew formula for kai
# Update version, URLs, and sha256 values when releasing a new version.
# Requires HOMEBREW_GITHUB_API_TOKEN for private repository access.

require_relative "lib/private_strategy"

class Kai < Formula
  desc "Local AI development assistant environment centered around Claude Code"
  homepage "https://github.com/kit-tech-jp/kit-ai"
  version "0.27.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/kit-tech-jp/kit-ai/releases/download/v#{version}/kai-darwin-arm64",
          using: ::GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "37c05687ebb2cfc9c8de72053da21b211129a7fa3b6634aea67aa6b1bbcabe32"
    else
      url "https://github.com/kit-tech-jp/kit-ai/releases/download/v#{version}/kai-darwin-x64",
          using: ::GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "32472bde36f2c42bbfe249312104bdc0b7b576ac5c951ac3e9ff0b2748d00057"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/kit-tech-jp/kit-ai/releases/download/v#{version}/kai-linux-arm64",
          using: ::GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "27ec2c08bce8dd61a737a942657b69372ab38916b03e10cd0fa8d5eca6e0e3c5"
    else
      url "https://github.com/kit-tech-jp/kit-ai/releases/download/v#{version}/kai-linux-x64",
          using: ::GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "e1e77ba2759060ffa510dd07e0bd860f1ef0020c8f0a049a5bf789ab96507438"
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
