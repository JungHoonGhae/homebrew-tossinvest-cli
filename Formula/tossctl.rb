class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.58.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.58.0/tossctl-darwin-arm64.tar.gz"
      sha256 "d5139c08fd724614bb04c03931fc2ef28249c28e4e667fa082901a1203526995"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.58.0/tossctl-darwin-amd64.tar.gz"
      sha256 "fe44cadac4000ac2ce629eea6fec28e23e4d33d99970fff2399bccc7b94927de"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.58.0/tossctl-linux-arm64.tar.gz"
      sha256 "d331cde72f4e22ad95e362ff97655e0b0565a1088445498a1aab0c85fa66c6b3"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.58.0/tossctl-linux-amd64.tar.gz"
      sha256 "00c13f988380910b0ae224043163f5d2c2c101b44f951a5f96b1dc21bf7c583c"
    end
  end

  def install
    libexec.install "tossctl"
    libexec.install "auth-helper"

    env = {
      "TOSSCTL_AUTH_HELPER_DIR" => libexec/"auth-helper",
      "TOSSCTL_AUTH_HELPER_PYTHON" => Formula["python@3.11"].opt_bin/"python3.11",
    }
    (bin/"tossctl").write_env_script libexec/"tossctl", env
  end

  test do
    assert_match "tossctl", shell_output("#{bin}/tossctl version")
  end
end
