class Feza < Formula
  desc "CLI tool"
  homepage "https://github.com/joshuboi77/Feza"
  version "0.5.15"


  # Python package - install via pip so wrapper script can import it
  depends_on "python@3.11"


  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.15/feza-darwin-arm64.tar.gz"
      sha256 "b590b1f60c5ea52a79dcd32b958d338c3402d5f96bd617a53b2497e627954fa4"
    else
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.15/feza-darwin-amd64.tar.gz"
      sha256 "3255cb48368b0b22e2dcdf70749a8c110d0b587c169e1fbda893902ee6e31728"
    end
  end

  on_linux do
    url "https://github.com/joshuboi77/Feza/releases/download/v0.5.15/feza-linux-amd64.tar.gz"
    sha256 "45c67b89bd33052bb28230bc335b5854e6671ad7bae2e4d5834d2088cf018711"
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
        File.write("setup.py", "from setuptools import setup; setup(name='feza', version='0.5.15')")
        system python3, "-m", "pip", "install", "--prefix", prefix, "--no-build-isolation", "."
      end
    end

  end

  test do
    assert_match "0.5.15", shell_output("#{bin}/feza --version")
  end
end
