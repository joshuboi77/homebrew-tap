class Feza < Formula
  desc "None"
  homepage "None"
  version "0.5.6"


  # Python package - install via pip so wrapper script can import it
  depends_on "python@3.11"


  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.6/feza-darwin-arm64.tar.gz"
      sha256 "ae70f1df570751062de1f0abe5ef2dbe87ed900159cc21ce68d4e3b012eb4da4"
    else
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.6/feza-darwin-amd64.tar.gz"
      sha256 "9243fc1d05c8dd5ab3254c3b13fc896b9326f6e3a62732b41623beb85887a809"
    end
  end

  on_linux do
    url "https://github.com/joshuboi77/Feza/releases/download/v0.5.6/feza-linux-amd64.tar.gz"
    sha256 "b8b3f9c4fad9595b676b72bafd070dc4bad0b3710ea8340a008bd1f006d13d08"
  end

  def install
    bin.install "feza"

    # Install Python package so wrapper script can import it
    # The wrapper script does "from feza.main import main" so package must be installed
    # Package source is included in the tarball, install from extracted source
    python3 = "python3.11"
    if File.exist?("pyproject.toml")
      # Install from pyproject.toml in the extracted tarball
      system python3, "-m", "pip", "install", "--prefix", prefix, "--no-build-isolation", "."
    elsif File.exist?("setup.py")
      # Fallback for setup.py
      system python3, "-m", "pip", "install", "--prefix", prefix, "--no-build-isolation", "."
    else
      # Try installing package name from bundled source
      package_dir = "feza"
      if Dir.exist?(package_dir)
        # Create a minimal setup.py if needed
        File.write("setup.py", "from setuptools import setup; setup(name='feza', version='0.5.6')")
        system python3, "-m", "pip", "install", "--prefix", prefix, "--no-build-isolation", "."
      end
    end

  end

  test do
    assert_match "0.5.6", shell_output("#{bin}/feza --version")
  end
end
