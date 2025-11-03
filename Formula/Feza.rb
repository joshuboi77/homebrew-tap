class Feza < Formula
  desc "None"
  homepage "None"
  version "0.4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/joshuboi77/Feza/releases/download/v0.4.0/feza-darwin-arm64.tar.gz"
      sha256 "7c76da149b26b3dde6d2c52fb0b9f86754dd302f9e3c60b531fb6abae5e66e3d"
    else
      url "https://github.com/joshuboi77/Feza/releases/download/v0.4.0/feza-darwin-amd64.tar.gz"
      sha256 "77ae56bb4b77386f0be74ecc3045df2fced36f864dec1fc3c94e06369e33c1f2"
    end
  end

  on_linux do
    url "https://github.com/joshuboi77/Feza/releases/download/v0.4.0/feza-linux-amd64.tar.gz"
    sha256 "88d10cbe1964166f2f38a3e54d4f91df13122fd142a8aa4e927f4d2aba957458"
  end

  def install
    bin.install "feza"
  end

  test do
    assert_match "0.4.0", shell_output("#{bin}/feza --version")
  end
end
