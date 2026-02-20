# Homebrew formula for kai
# Update version, URLs, and sha256 values when releasing a new version.

class Kai < Formula
  desc "Local AI development assistant environment centered around Claude Code"
  homepage "https://github.com/kit-tech-jp/kit-ai"
  version "0.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/kit-tech-jp/kit-ai/releases/download/v#{version}/kai-darwin-arm64"
      sha256 "36a40d5d5a0e42709204416f8550b5b8803178cce714dff4a2c24344f18db262"
    else
      url "https://github.com/kit-tech-jp/kit-ai/releases/download/v#{version}/kai-darwin-x64"
      sha256 "ca0fd0538c0c4f28cf8307818d159c0f23132dd14188435759520a8056375ed3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/kit-tech-jp/kit-ai/releases/download/v#{version}/kai-linux-arm64"
      sha256 "abb59d3c16742d13b262deb2a58caf6f1756e53e875d5cb6b20345d56f8f9527"
    else
      url "https://github.com/kit-tech-jp/kit-ai/releases/download/v#{version}/kai-linux-x64"
      sha256 "5e44be5c91d97995dfb457beb7d01af2c2d2b92687b3e99ce9c1b9cde88de871"
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
