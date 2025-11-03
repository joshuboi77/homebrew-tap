class Feza < Formula
  desc "None"
  homepage "None"
  version "0.5.12"


  # Python package - install via pip so wrapper script can import it
  depends_on "python@3.11"


  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.12/feza-darwin-arm64.tar.gz"
      sha256 "a9868d48b03a94b629baa576c3ff4fab53fa1b8f0ccfaf7692ad8bfdf263bc60"
    else
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.12/feza-darwin-amd64.tar.gz"
      sha256 "a184f08160e877faa9d2647722daab0ef5365e7e43da50079b1a63f5f4ca26d7"
    end
  end

  on_linux do
    url "https://github.com/joshuboi77/Feza/releases/download/v0.5.12/feza-linux-amd64.tar.gz"
    sha256 "ae5d84b58c418b0e3213c21e1df84488418c99e39b33149a0cd376903ba402dc"
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
        File.write("setup.py", "from setuptools import setup; setup(name='feza', version='0.5.12')")
        system python3, "-m", "pip", "install", "--prefix", prefix, "--no-build-isolation", "."
      end
    end

  end

  test do
    assert_match "0.5.12", shell_output("#{bin}/feza --version")
  end
end
