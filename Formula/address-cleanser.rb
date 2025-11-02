class AddressCleanser < Formula
  desc "Parse, validate, and format US addresses"
  homepage "https://github.com/joshuboi77/address-cleanser"
  version "1.0.19"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/joshuboi77/address-cleanser/releases/download/v1.0.19/address-cleanser-macos-arm64.zip"
      sha256 "369d6abc29ac9de556cf3c89005fe819b1acff1e29cef5f096e579bf3e816e92"
    else
      url "https://github.com/joshuboi77/address-cleanser/releases/download/v1.0.18/address-cleanser-macos-universal.zip"
      sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
    end
  end

  def install
    bin.install "address-cleanser"
  end

  test do
    output = shell_output("#{bin}/address-cleanser --help")
    assert_match "Usage:", output
  end
end

