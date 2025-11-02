class AddressCleanser < Formula
  desc "Parse, validate, and format US addresses"
  homepage "https://github.com/joshuboi77/address-cleanser"
  version "1.0.18"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/joshuboi77/address-cleanser/releases/download/v1.0.18/address-cleanser-macos-arm64.zip"
      sha256 "43390bc0d46e705a6eebf6343bc22c4ff118e94a9cc4f3901e83bb63334a91ff"
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

