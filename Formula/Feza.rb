class Feza < Formula
  desc "None"
  homepage "None"
  version "0.5.11"


  # Python package - install via pip so wrapper script can import it
  depends_on "python@3.11"


  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.11/feza-darwin-arm64.tar.gz"
      sha256 "5bca9c3b67e918874ead13d00c8b647b53ddfba5a6d5d265da290739ccb0d285"
    else
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.11/feza-darwin-amd64.tar.gz"
      sha256 "e79f7aebfc6d8be3c0a0168248da8ad5c29e69a084e1855126981b73bfa7c4d2"
    end
  end

  on_linux do
    url "https://github.com/joshuboi77/Feza/releases/download/v0.5.11/feza-linux-amd64.tar.gz"
    sha256 "0652a86a5a99a7d98bd1ea87022fd5fe429d9dfdb5bbba2d11a7ed07ff14c2dc"
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
        File.write("setup.py", "from setuptools import setup; setup(name='feza', version='0.5.11')")
        system python3, "-m", "pip", "install", "--prefix", prefix, "--no-build-isolation", "."
      end
    end

  end

  test do
    assert_match "0.5.11", shell_output("#{bin}/feza --version")
  end
end
