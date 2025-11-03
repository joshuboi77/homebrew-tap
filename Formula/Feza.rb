class Feza < Formula
  desc "None"
  homepage "None"
  version "0.5.10"


  # Python package - install via pip so wrapper script can import it
  depends_on "python@3.11"


  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.10/feza-darwin-arm64.tar.gz"
      sha256 "07386ecc5d53cb16dd4c5823c0aabfaa6830053b0e0440bfb1c4f881ced8a187"
    else
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.10/feza-darwin-amd64.tar.gz"
      sha256 "adc82809049cadeec378f56f932aed28d94b0b8a0534bcb497e0ccbeacf5b982"
    end
  end

  on_linux do
    url "https://github.com/joshuboi77/Feza/releases/download/v0.5.10/feza-linux-amd64.tar.gz"
    sha256 "20513dbab5c24dc10964e729c25ffdab4e904b3e3d99a5ce02db0d5a10d731ae"
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
        File.write("setup.py", "from setuptools import setup; setup(name='feza', version='0.5.10')")
        system python3, "-m", "pip", "install", "--prefix", prefix, "--no-build-isolation", "."
      end
    end

  end

  test do
    assert_match "0.5.10", shell_output("#{bin}/feza --version")
  end
end
