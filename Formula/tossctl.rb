class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.1.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.1.0/tossctl-darwin-arm64.tar.gz"
      sha256 "c24c8fb7e77affff999acc588d983c171da7b6f0425018154aca94d9d84fe957"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.1.0/tossctl-darwin-amd64.tar.gz"
      sha256 "6bfccec34607c51add9cf88eed5bd0bb843ee287533545141a35f77dab2a0741"
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
