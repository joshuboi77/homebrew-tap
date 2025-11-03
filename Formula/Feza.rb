class Feza < Formula
  desc "None"
  homepage "None"
  version "0.5.13"


  # Python package - install via pip so wrapper script can import it
  depends_on "python@3.11"


  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.13/feza-darwin-arm64.tar.gz"
      sha256 "211c848f66c11ae6bbf5bef6646c3fb593048cbde3f5baa7038627903de6f7e8"
    else
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.13/feza-darwin-amd64.tar.gz"
      sha256 "b2fb1fc0664ea3def8eeec360458ad98b87fc0abae67ebdd1472f3411a33438f"
    end
  end

  on_linux do
    url "https://github.com/joshuboi77/Feza/releases/download/v0.5.13/feza-linux-amd64.tar.gz"
    sha256 "666091edf4531c34345802822fbf80654dc6cb20bf23de01327d4ab637334f1c"
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
        File.write("setup.py", "from setuptools import setup; setup(name='feza', version='0.5.13')")
        system python3, "-m", "pip", "install", "--prefix", prefix, "--no-build-isolation", "."
      end
    end

  end

  test do
    assert_match "0.5.13", shell_output("#{bin}/feza --version")
  end
end
