class Feza < Formula
  desc "None"
  homepage "None"
  version "0.5.5"


  # Python package - install via pip so wrapper script can import it
  depends_on "python@3.11"


  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.5/feza-darwin-arm64.tar.gz"
      sha256 "cca51454f0b6991724b03a327495a799e91b03915f1f5f45f95c89c58b29f8cb"
    else
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.5/feza-darwin-amd64.tar.gz"
      sha256 "a3bd758a6059464ef99adfbc39f91ef00ff479a713afbf2e16deeb6b7fb7e2ee"
    end
  end

  on_linux do
    url "https://github.com/joshuboi77/Feza/releases/download/v0.5.5/feza-linux-amd64.tar.gz"
    sha256 "517e3071ffbb8342e4f9cba877336057fadfd6fe238879c8dee67cb917f46fe8"
  end

  def install
    bin.install "feza"

    # Install Python package so wrapper script can import it
    # The wrapper script does "from feza.main import main" so package must be installed
    python3 = "python3.11"
    system python3, "-m", "pip", "install", "--prefix", prefix, "feza==0.5.5"

  end

  test do
    assert_match "0.5.5", shell_output("#{bin}/feza --version")
  end
end
