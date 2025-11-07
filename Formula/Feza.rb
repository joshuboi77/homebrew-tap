class Feza < Formula
  desc "CLI tool"
  homepage "https://github.com/joshuboi77/Feza"
  version "0.5.21"


  # Python package - install via pip so wrapper script can import it
  depends_on "python@3.11"


  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.21/feza-darwin-arm64.tar.gz"
      sha256 "eeb9e3b4a4d9b19a369e0d2672c1f783c515169d501f9368ee6b2bc34122d8cb"
    else
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.21/feza-darwin-amd64.tar.gz"
      sha256 "629e1b6ee67052211e3e7a67c6bc175cb14ad3e0ec2dd256301e1d6d7b58d70c"
    end
  end

  on_linux do
    url "https://github.com/joshuboi77/Feza/releases/download/v0.5.21/feza-linux-amd64.tar.gz"
    sha256 "d5e7488af443acc59ccf121620058e6ab6e03c0354e49f77c6a44a506710a216"
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
        File.write("setup.py", "from setuptools import setup; setup(name='feza', version='0.5.21')")
        system python3, "-m", "pip", "install", "--prefix", prefix, "--no-build-isolation", "."
      end
    end

  end

  test do
    assert_match "0.5.21", shell_output("#{bin}/feza --version")
  end
end
