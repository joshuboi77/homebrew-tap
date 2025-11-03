class Feza < Formula
  desc "CLI tool"
  homepage "https://github.com/joshuboi77/Feza"
  version "0.5.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.0/feza-darwin-arm64.tar.gz"
      sha256 "42de9fa513832c79adef0de01657f4111e13882b8b6f920f392ee329ab0cfa0e"
    else
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.0/feza-darwin-amd64.tar.gz"
      sha256 "0f3bb0fb56ee1831d03416904c3c464bb36a14f39117a634fbc54e29f416ea00"
    end
  end

  on_linux do
    url "https://github.com/joshuboi77/Feza/releases/download/v0.5.0/feza-linux-amd64.tar.gz"
    sha256 "5f01c2c40144f883411e86fa4df95df9478e2f5ee68f1e1dccb40ac292cc2b2f"
  end

  def install
    bin.install "feza"
  end

  test do
    assert_match "0.5.0", shell_output("#{bin}/feza --version")
  end
end
