class Feza < Formula
  desc "CLI tool"
  homepage "https://github.com/joshuboi77/Feza"
  version "0.5.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.0/feza-darwin-arm64.tar.gz"
      sha256 "80abd6d0da5caa62985132c5b2050441cb4b6b1894648ba36bc6e9e4e28131a7"
    else
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.0/feza-darwin-amd64.tar.gz"
      sha256 "e19e2f1c19540b3c358d9aacc6910b33baec3d941f332a28b523c412858fef5c"
    end
  end

  on_linux do
    url "https://github.com/joshuboi77/Feza/releases/download/v0.5.0/feza-linux-amd64.tar.gz"
    sha256 "0df44c6c032d32fa424ed23578cdd1a912d854d0fda6f1659d54458d3755b7a2"
  end

  def install
    bin.install "feza"
  end

  test do
    assert_match "0.5.0", shell_output("#{bin}/feza --version")
  end
end
