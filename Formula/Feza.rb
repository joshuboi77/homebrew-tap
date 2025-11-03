class Feza < Formula
  desc "None"
  homepage "None"
  version "0.5.8"


  # Python package - install via pip so wrapper script can import it
  depends_on "python@3.11"


  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.8/feza-darwin-arm64.tar.gz"
      sha256 "4a948ad802164e252bb7f0fb27b9d86ef1e7134406c6d822e0f3949b3e4bc6c8"
    else
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.8/feza-darwin-amd64.tar.gz"
      sha256 "e508254825fdf54e5677e438b316725e516687d1c06af55af28dcffe6cf56269"
    end
  end

  on_linux do
    url "https://github.com/joshuboi77/Feza/releases/download/v0.5.8/feza-linux-amd64.tar.gz"
    sha256 "4b2bb30d711baa8eb51f68bde88c6b62d2d636d65a43df0869a4fb6f6260691f"
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
        File.write("setup.py", "from setuptools import setup; setup(name='feza', version='0.5.8')")
        system python3, "-m", "pip", "install", "--prefix", prefix, "--no-build-isolation", "."
      end
    end

  end

  test do
    assert_match "0.5.8", shell_output("#{bin}/feza --version")
  end
end
