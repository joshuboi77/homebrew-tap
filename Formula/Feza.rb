class Feza < Formula
  desc "CLI tool"
  homepage "https://github.com/joshuboi77/Feza"
  version "0.3.17"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/joshuboi77/Feza/releases/download/v0.3.17/feza-darwin-arm64.tar.gz"
      sha256 "2586b9bbf6d4ba6dfed7a0f14d4c0a8067f5b53a09f3d527341da44a8a1e09ce"
    else
      url "https://github.com/joshuboi77/Feza/releases/download/v0.3.17/feza-darwin-amd64.tar.gz"
      sha256 "d1eab23a050848e88e000145a70a4d2a298d7e26201d43c4e065fa5f177263cc"
    end
  end

  on_linux do
    url "https://github.com/joshuboi77/Feza/releases/download/v0.3.17/feza-linux-amd64.tar.gz"
    sha256 "b95699aed3a8ab3aab88a581a0d443e2f7e4453ecd583ecdd8d30cf870a3cde8"
  end

  def install
    bin.install "feza"
  end

  test do
    assert_match "0.3.17", shell_output("#{bin}/feza --version")
  end
end
