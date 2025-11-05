class Feza < Formula
  desc "CLI tool"
  homepage "https://github.com/joshuboi77/Feza"
  version "0.5.16"


  # Python package - install via pip so wrapper script can import it
  depends_on "python@3.11"


  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.16/feza-darwin-arm64.tar.gz"
      sha256 "d2d8e97f77c54b58f2e305fd52bdbd6ec1db560e61679c4f062ebcd20d198753"
    else
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.16/feza-darwin-amd64.tar.gz"
      sha256 "13b510bc42c65e001f9c6558a5372b67af9845782385f1cc6c58cf13d4b5452b"
    end
  end

  on_linux do
    url "https://github.com/joshuboi77/Feza/releases/download/v0.5.16/feza-linux-amd64.tar.gz"
    sha256 "abe8e7a85b0a7c665ad2b355e017288ee7b66a77a5f2acf38d8c13f214b3dfa1"
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
        File.write("setup.py", "from setuptools import setup; setup(name='feza', version='0.5.16')")
        system python3, "-m", "pip", "install", "--prefix", prefix, "--no-build-isolation", "."
      end
    end

  end

  test do
    assert_match "0.5.16", shell_output("#{bin}/feza --version")
  end
end
