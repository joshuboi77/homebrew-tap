class Feza < Formula
  desc "None"
  homepage "None"
  version "0.5.14"


  # Python package - install via pip so wrapper script can import it
  depends_on "python@3.11"


  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.14/feza-darwin-arm64.tar.gz"
      sha256 "72af8fe329fcd5ad2ee3808a64bb03e5a5cb5538a03d378fbd70205faa4721c0"
    else
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.14/feza-darwin-amd64.tar.gz"
      sha256 "d0069249a4175a4df502c57c015ecdedeb9182e95b4374403fdb31040b0a80e9"
    end
  end

  on_linux do
    url "https://github.com/joshuboi77/Feza/releases/download/v0.5.14/feza-linux-amd64.tar.gz"
    sha256 "a2f57b71d41ea7c8025a3f252f5e377a6b130aa04c4b3fafd80f6b4f8f5f9da7"
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
        File.write("setup.py", "from setuptools import setup; setup(name='feza', version='0.5.14')")
        system python3, "-m", "pip", "install", "--prefix", prefix, "--no-build-isolation", "."
      end
    end

  end

  test do
    assert_match "0.5.14", shell_output("#{bin}/feza --version")
  end
end
