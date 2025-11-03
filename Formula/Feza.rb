class Feza < Formula
  desc "None"
  homepage "None"
  version "0.5.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.1/feza-darwin-arm64.tar.gz"
      sha256 "d5845607bb4ce71e7f1128be0fc2e90cab82275977bcb8e1c18378c42047c0e4"
    else
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.1/feza-darwin-amd64.tar.gz"
      sha256 "a77d35356b37df0984ce3c8ad257557739243b22ebeb2ad3c9a8fa8c3c0ba17a"
    end
  end

  on_linux do
    url "https://github.com/joshuboi77/Feza/releases/download/v0.5.1/feza-linux-amd64.tar.gz"
    sha256 "ebdc0c360b7d28dd98ca9d983a4eeeb9a48754aee4a483e6d2703bfad9080a28"
  end

  def install
    bin.install "feza"
  end

  test do
    assert_match "0.5.1", shell_output("#{bin}/feza --version")
  end
end
