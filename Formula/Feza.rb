class Feza < Formula
  desc "None"
  homepage "None"
  version "0.5.7"


  # Python package - install via pip so wrapper script can import it
  depends_on "python@3.11"


  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.7/feza-darwin-arm64.tar.gz"
      sha256 "31feb9e970dc15513c647b773dafe5a774da1d2ebfceddd84e2f103060d30496"
    else
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.7/feza-darwin-amd64.tar.gz"
      sha256 "d8445d592b6e4a70b2b106a137ae9449b58c1e854063805dcc2cf0109e83c3e4"
    end
  end

  on_linux do
    url "https://github.com/joshuboi77/Feza/releases/download/v0.5.7/feza-linux-amd64.tar.gz"
    sha256 "91a6314b61f001f92a481c6d5555a6c2ad247ae6b8f21a44d1d36c812e779da1"
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
        File.write("setup.py", "from setuptools import setup; setup(name='feza', version='0.5.7')")
        system python3, "-m", "pip", "install", "--prefix", prefix, "--no-build-isolation", "."
      end
    end

  end

  test do
    assert_match "0.5.7", shell_output("#{bin}/feza --version")
  end
end
