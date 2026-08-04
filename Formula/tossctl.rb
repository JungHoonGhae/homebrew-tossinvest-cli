class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.37.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.37.0/tossctl-darwin-arm64.tar.gz"
      sha256 "0937574f51d6224abc254adba99ec0595e6d816c025e06c62a99e8f7556b1613"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.37.0/tossctl-darwin-amd64.tar.gz"
      sha256 "dc58efdd3a5ff986ee48669e8b16aad81181da4d70126c641ff54f9045dae4d5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.37.0/tossctl-linux-arm64.tar.gz"
      sha256 "86d565f768ee15d796d757659ee94075b074a69b5db201d91f3ef0ee29f8b83c"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.37.0/tossctl-linux-amd64.tar.gz"
      sha256 "48aeb8d0b8962662fb834fb3a2e09c126ceadd9f2b0c4253d87dc82df243b51c"
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
