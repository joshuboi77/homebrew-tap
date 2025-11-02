class AddressCleanser < Formula
  desc "Parse, validate, and format US addresses"
  homepage "https://github.com/joshuboi77/address-cleanser"
  version "1.0.28"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/joshuboi77/address-cleanser/releases/download/v1.0.28/address-cleanser-macos-arm64.zip"
      sha256 "1733177408ee89fbb49fe97a0784dd033ff1a6bd587a85eb6cd23c4fcf4fed2f"
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

