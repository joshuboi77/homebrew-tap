class Feza < Formula
  desc "CLI tool to plan, build, publish, and tap releases"
  homepage "https://github.com/joshuboi77/Feza"
  version "0.1.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/joshuboi77/Feza/releases/download/v0.1.0/feza-darwin-arm64.tar.gz"
      sha256 "68477db010d32dcaee3a34a80db243e4d2b5d51e607c90b315625dd227fcc528"
    else
      url "https://github.com/joshuboi77/Feza/releases/download/v0.1.0/feza-darwin-amd64.tar.gz"
      sha256 "e5823ff66f0d16c99a3eeb8d4c9ca28b425cf488ba29d6274303a02d2e52ce55"
    end
  end

  on_linux do
    url "https://github.com/joshuboi77/Feza/releases/download/v0.1.0/feza-linux-amd64.tar.gz"
    sha256 "dfe6c64101ceccd026b0f0a9ae3d4a2575ddb2afbb7370c8aa3270ecce882a16"
  end

  def install
    bin.install "feza"
  end

  test do
    assert_match "0.1.0", shell_output("#{bin}/feza --version")
  end
end
