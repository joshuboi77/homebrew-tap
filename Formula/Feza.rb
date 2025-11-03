class Feza < Formula
  desc "None"
  homepage "None"
  version "0.5.9"


  # Python package - install via pip so wrapper script can import it
  depends_on "python@3.11"


  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.9/feza-darwin-arm64.tar.gz"
      sha256 "1cb9e87d29a676f20e7ef43ed744d7323c20d52fc8132b4a10891fe794aa0acb"
    else
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.9/feza-darwin-amd64.tar.gz"
      sha256 "c13e60a0a924ff78478bb0658449ff8a025f1ef6287064d1bcc53325faa54426"
    end
  end

  on_linux do
    url "https://github.com/joshuboi77/Feza/releases/download/v0.5.9/feza-linux-amd64.tar.gz"
    sha256 "cdf7c778e76399a08d24d308b1cad9205f18dfd33014aa73098a1647afd4e7c6"
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
        File.write("setup.py", "from setuptools import setup; setup(name='feza', version='0.5.9')")
        system python3, "-m", "pip", "install", "--prefix", prefix, "--no-build-isolation", "."
      end
    end

  end

  test do
    assert_match "0.5.9", shell_output("#{bin}/feza --version")
  end
end
