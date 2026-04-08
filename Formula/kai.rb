# Homebrew formula for kai
# Update version, URLs, and sha256 values when releasing a new version.
# Requires HOMEBREW_GITHUB_API_TOKEN for private repository access.

require_relative "lib/private_strategy"

class Kai < Formula
  desc "Local AI development assistant environment centered around Claude Code"
  homepage "https://github.com/kit-tech-jp/kit-ai"
  version "0.15.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/kit-tech-jp/kit-ai/releases/download/v#{version}/kai-darwin-arm64",
          using: ::GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "9c8d3355d33e2fbc7f73f8be5d6c7689261c9f5d8460a1506922b603493fb48a"
    else
      url "https://github.com/kit-tech-jp/kit-ai/releases/download/v#{version}/kai-darwin-x64",
          using: ::GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "0462ad7b8a6b9317c4194c33431061f47563750e081a03f0c79711d8e5d8c098"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/kit-tech-jp/kit-ai/releases/download/v#{version}/kai-linux-arm64",
          using: ::GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "600e4307709b6db90966906818efa1f0e00590e75154fcc8ff7259bcf7dd97d2"
    else
      url "https://github.com/kit-tech-jp/kit-ai/releases/download/v#{version}/kai-linux-x64",
          using: ::GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "07b0903844194444bd1357c6c19a425987c7a284db0171a189f683cbd9614005"
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
