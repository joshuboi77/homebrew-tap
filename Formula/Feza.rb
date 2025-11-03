class Feza < Formula
  desc "None"
  homepage "None"
  version "0.5.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.4/feza-darwin-arm64.tar.gz"
      sha256 "67aa8e68a86cd71bd2f280ae3c8927598de2b3df463b2437ae966fb2eb08225c"
    else
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.4/feza-darwin-amd64.tar.gz"
      sha256 "c30029d134f89f58ad1703a3b3aff8fbcbcd647173a42ef0599005d50b31476d"
    end
  end

  on_linux do
    url "https://github.com/joshuboi77/Feza/releases/download/v0.5.4/feza-linux-amd64.tar.gz"
    sha256 "d6cfafdf300563e272fa040aa37ae7a356bc0ef8fd0d5b8833d669daf699f164"
  end

  def install
    bin.install "feza"
  end

  test do
    assert_match "0.5.4", shell_output("#{bin}/feza --version")
  end
end
