class Feza < Formula
  desc "None"
  homepage "None"
  version "0.5.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.2/feza-darwin-arm64.tar.gz"
      sha256 "53ea67eab2d040d16be75aa30e59c90fbc0e752637f8da27723f19efdbda6154"
    else
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.2/feza-darwin-amd64.tar.gz"
      sha256 "8a76c045553d9e3998f7311e924717683fbf067d33b0b7e61cc62086d84ea142"
    end
  end

  on_linux do
    url "https://github.com/joshuboi77/Feza/releases/download/v0.5.2/feza-linux-amd64.tar.gz"
    sha256 "16322f5bd63dd9185840eb3cd472cb6187035b3f2429f43559367e7349d312b2"
  end

  def install
    bin.install "feza"
  end

  test do
    assert_match "0.5.2", shell_output("#{bin}/feza --version")
  end
end
