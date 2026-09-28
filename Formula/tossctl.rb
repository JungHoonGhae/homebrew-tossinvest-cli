class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.53.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.53.0/tossctl-darwin-arm64.tar.gz"
      sha256 "997f2af1d566c28b00395f6b443961d6a1ddb2e96357ee7ed5acb48f43f38e6f"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.53.0/tossctl-darwin-amd64.tar.gz"
      sha256 "b486d43a36934ae4aab935fba2d3e2565e0706e7e83b30592e1523d215022b3f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.53.0/tossctl-linux-arm64.tar.gz"
      sha256 "b99d7261c2d08f03bb539a4a9bcfaab0fad55dab75e3b7dfa7f29ada83465395"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.53.0/tossctl-linux-amd64.tar.gz"
      sha256 "710fd958b0adc5293e8dcc8d529738b7ad335b65908ae0a3651e14d951efaadc"
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
