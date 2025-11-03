class Feza < Formula
  desc "CLI tool"
  homepage "https://github.com/joshuboi77/Feza"
  version "0.5.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.2/feza-darwin-arm64.tar.gz"
      sha256 "78b2216f0120f20143953881159cb7b6eb3963f93e412bf05524dc9768b24e56"
    else
      url "https://github.com/joshuboi77/Feza/releases/download/v0.5.2/feza-darwin-amd64.tar.gz"
      sha256 "a9a49b6b9882a3a9e17d941b54ddc6972e755b7f22451276a23a90f2fdd5fbe9"
    end
  end

  on_linux do
    url "https://github.com/joshuboi77/Feza/releases/download/v0.5.2/feza-linux-amd64.tar.gz"
    sha256 "8e07dba44f3ef505feeb1cce3182134c69c150783bd075c7c54091a3a678990a"
  end

  def install
    bin.install "feza"
  end

  test do
    assert_match "0.5.2", shell_output("#{bin}/feza --version")
  end
end
