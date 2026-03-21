class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.2.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.2.0/tossctl-darwin-arm64.tar.gz"
      sha256 "366cefd2c02937c5f111dafe83a5b7332ae6d3a4b7d178352f99a74ffd74013a"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.2.0/tossctl-darwin-amd64.tar.gz"
      sha256 "a40f3d28f7c2c44b253088cde1f5bfbb05046b41e65868c398d5ffdfe9c32e78"
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
