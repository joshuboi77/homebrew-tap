class Feza < Formula
  desc "CLI tool"
  homepage "https://github.com/joshuboi77/Feza"
  version "0.5.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.1/feza-darwin-arm64.tar.gz"
      sha256 "678576474eb8a29b5077d096f2b5a1c2b5a0036cd377f953af300d44e0955e1a"
    else
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.1/feza-darwin-amd64.tar.gz"
      sha256 "f07d936c6d71892590b852baac314a18be7fecbb34e64c3893a56344115954c9"
    end
  end

  on_linux do
    url "https://github.com/joshuboi77/Feza/releases/download/v0.5.1/feza-linux-amd64.tar.gz"
    sha256 "e749c07eac6b7531494397f0ede0952614a9740050bd9d294919d7372af6ebe1"
  end

  def install
    bin.install "feza"
  end

  test do
    assert_match "0.5.1", shell_output("#{bin}/feza --version")
  end
end
