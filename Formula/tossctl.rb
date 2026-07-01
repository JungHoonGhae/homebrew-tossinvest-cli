class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.14.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.14.0/tossctl-darwin-arm64.tar.gz"
      sha256 "ac0a795cfe70c9ca3c78e337cd6c8092468c932994f53ee5c2ba5ed6b4d99c9b"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.14.0/tossctl-darwin-amd64.tar.gz"
      sha256 "22cfa55fc87b85b0126e4dcc21bcaa449ddb1b83478af3635ce4a37b10dc1559"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.14.0/tossctl-linux-arm64.tar.gz"
      sha256 "bd3465ed0a9851e08ee2e936e2fa0ab938949acd98901e9ac44185c73df760b4"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.14.0/tossctl-linux-amd64.tar.gz"
      sha256 "4b0097ad05ed5a481afbccb7ebf57f3c6baade32fca9c9239da6a09fb38ac869"
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
