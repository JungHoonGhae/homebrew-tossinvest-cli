class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.46.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.46.0/tossctl-darwin-arm64.tar.gz"
      sha256 "21caed3a50e7ae5d240b8e48651be66df74db1ecb75098e2bfc360d4ff8e4767"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.46.0/tossctl-darwin-amd64.tar.gz"
      sha256 "52da2c44c0ffef748a89eb2843295e92cd110a0e39fe061ecfcc1e1c789e7f09"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.46.0/tossctl-linux-arm64.tar.gz"
      sha256 "197e8da6098f413b4ffc0bb936b98d4ae46f120fabea16f67bb1a975b31814fa"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.46.0/tossctl-linux-amd64.tar.gz"
      sha256 "3f993e3d20add9be883ae9718bf668568a283c0ec51bd9c2c76b7351dae8ce03"
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
