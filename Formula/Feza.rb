class Feza < Formula
  desc "None"
  homepage "None"
  version "0.5.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.3/feza-darwin-arm64.tar.gz"
      sha256 "9fd21f40e223644ac4d1499c652b2ff66167544974497d052c470cff7b87e119"
    else
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.3/feza-darwin-amd64.tar.gz"
      sha256 "9120e9c0030fbc28ed2e6c0e3fdbf1be194d2c32fab5814bc896651b42823162"
    end
  end

  on_linux do
    url "https://github.com/joshuboi77/Feza/releases/download/v0.5.3/feza-linux-amd64.tar.gz"
    sha256 "b8f760b14d6865422b2f9db1aea9d7f36b528edd01ba31470428b00d6eb33a86"
  end

  def install
    bin.install "feza"
  end

  test do
    assert_match "0.5.3", shell_output("#{bin}/feza --version")
  end
end
