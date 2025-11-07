class Feza < Formula
  desc "CLI tool"
  homepage "https://github.com/joshuboi77/Feza"
  version "0.5.22"


  # Python package - install via pip so wrapper script can import it
  depends_on "python@3.11"


  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.22/feza-darwin-arm64.tar.gz"
      sha256 "be512839e11c8cf45d9191f475cf15bf79bf8587a45c9b5b3c465566beb8f7df"
    else
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.22/feza-darwin-amd64.tar.gz"
      sha256 "26c55bb90f9d3d632e0b472bd559907d172b68a0366d14cc7d373a617cb2ae9a"
    end
  end

  on_linux do
    url "https://github.com/joshuboi77/Feza/releases/download/v0.5.22/feza-linux-amd64.tar.gz"
    sha256 "dacbd56f4c45da524dfb5e2b96ca313e2dbbe1927bcd506dbe52afd60c6a6349"
  end

  def install
    # Install wrapper script from bin/ directory in tarball
    bin.install "bin/feza" => "feza"

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
        File.write("setup.py", "from setuptools import setup; setup(name='feza', version='0.5.22')")
        system python3, "-m", "pip", "install", "--prefix", prefix, "--no-build-isolation", "."
      end
    end

  end

  test do
    assert_match "0.5.22", shell_output("#{bin}/feza --version")
  end
end
