class Feza < Formula
  desc "CLI tool"
  homepage "https://github.com/joshuboi77/Feza"
  version "0.5.20"


  # Python package - install via pip so wrapper script can import it
  depends_on "python@3.11"


  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.20/feza-darwin-arm64.tar.gz"
      sha256 "c46dadc5c3e93207c19bc97fc978c00a54eccec9d379e9d33712868e72881b5e"
    else
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.20/feza-darwin-amd64.tar.gz"
      sha256 "fa5b9b0a1d8892c31ed2690afebb0b8b4a8345057e7bbfe81cb075ffe56a9c8e"
    end
  end

  on_linux do
    url "https://github.com/joshuboi77/Feza/releases/download/v0.5.20/feza-linux-amd64.tar.gz"
    sha256 "a936c6e2f51df2197e1524dd068b7b4afa9a1ffb70abfe03b790daf546c028f7"
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
        File.write("setup.py", "from setuptools import setup; setup(name='feza', version='0.5.20')")
        system python3, "-m", "pip", "install", "--prefix", prefix, "--no-build-isolation", "."
      end
    end

  end

  test do
    assert_match "0.5.20", shell_output("#{bin}/feza --version")
  end
end
