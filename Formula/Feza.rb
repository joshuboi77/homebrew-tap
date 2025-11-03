class Feza < Formula
  desc "CLI tool"
  homepage "https://github.com/joshuboi77/Feza"
  version "0.4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/joshuboi77/Feza/releases/download/v0.4.0/feza-darwin-arm64.tar.gz"
      sha256 "dc48b4dfb8ff4b689929b227092a1fb853c52019d1eba3618b69b926713b1efe"
    else
      url "https://github.com/joshuboi77/Feza/releases/download/v0.4.0/feza-darwin-amd64.tar.gz"
      sha256 "2d0b2b67b7c3872eb6dffaab7588076de36897943f8215c5765298072e733db7"
    end
  end

  on_linux do
    url "https://github.com/joshuboi77/Feza/releases/download/v0.4.0/feza-linux-amd64.tar.gz"
    sha256 "f0f2b596721890f6a14364410d434a04a2b08f5e3346ed3a4763518f82937ae0"
  end

  def install
    bin.install "feza"
  end

  test do
    assert_match "0.4.0", shell_output("#{bin}/feza --version")
  end
end
