class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.25.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.25.0/tossctl-darwin-arm64.tar.gz"
      sha256 "5d0f91955a706d612dd208a6a3a2eeaa1c39480413d750f1b14a830b2a339b46"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.25.0/tossctl-darwin-amd64.tar.gz"
      sha256 "9c86060fe83ec9cf6996c4f9eb4059c59f1cd41c97b3a8326af07a225c877f80"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.25.0/tossctl-linux-arm64.tar.gz"
      sha256 "5a66077d24dc9097dd3eb3705d6859824de25de7a11fe46f66746063eb1ef2b2"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.25.0/tossctl-linux-amd64.tar.gz"
      sha256 "ff242d2519b67dc5521cca116a356e9b59a3225ab97d3e4b0e2b27eb0504fffc"
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
