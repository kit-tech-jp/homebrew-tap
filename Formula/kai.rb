# Homebrew formula for kai
# Update version, URLs, and sha256 values when releasing a new version.
# Requires HOMEBREW_GITHUB_API_TOKEN for private repository access.

require_relative "lib/private_strategy"

class Kai < Formula
  desc "Local AI development assistant environment centered around Claude Code"
  homepage "https://github.com/kit-tech-jp/kit-ai"
  version "0.14.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/kit-tech-jp/kit-ai/releases/download/v#{version}/kai-darwin-arm64",
          using: ::GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "86034ccd5430f74325de43ef430dc50120da90523872797d01549b8f9ac70d52"
    else
      url "https://github.com/kit-tech-jp/kit-ai/releases/download/v#{version}/kai-darwin-x64",
          using: ::GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "e69fb353e655159a49118cfbc451a0f6608aef17c511aa6d277a3160c73dea57"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/kit-tech-jp/kit-ai/releases/download/v#{version}/kai-linux-arm64",
          using: ::GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "c394afdac1e0e8fa532b2282516b6abdb416cd96aa61710f3d1a2b9f59309cb2"
    else
      url "https://github.com/kit-tech-jp/kit-ai/releases/download/v#{version}/kai-linux-x64",
          using: ::GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "aaaffee0e3ac121dd29b93736537af683c2ebb9d34f8394fcdb7dd507835a273"
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
