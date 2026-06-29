class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.13.1"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.13.1/tossctl-darwin-arm64.tar.gz"
      sha256 "a866d9b522f551219ef93cf9c45f5c5a9c1580f5194291bc25969b2314c57590"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.13.1/tossctl-darwin-amd64.tar.gz"
      sha256 "a29a3318e238a479c936daebaca2be820d805b3ebd6213a0e5ea9de8e94a1796"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.13.1/tossctl-linux-arm64.tar.gz"
      sha256 "4005bc27c14b6a609558b0fb2c03a66ae2686606bc76ade814ffb51557043b32"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.13.1/tossctl-linux-amd64.tar.gz"
      sha256 "6de13b82418facdc1ebb6ee3853b6f8663f82c05bce4dbc10cae41de04f4aa18"
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
