class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.24.1"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.24.1/tossctl-darwin-arm64.tar.gz"
      sha256 "9f142fc8b6bc2a3fdc875e7d070bd33607b92042f4eeb6780cdb0f686f55475c"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.24.1/tossctl-darwin-amd64.tar.gz"
      sha256 "6fde208552c8eef7d1be97a323f74a86438ced0bee9f1362af4ff3eec5d9d991"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.24.1/tossctl-linux-arm64.tar.gz"
      sha256 "218108d0e8b41a617d96e5c0063216449ad59a792fa3c9bb1778d536819189f0"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.24.1/tossctl-linux-amd64.tar.gz"
      sha256 "6293fadcea08b50784dac0031bcbfb48b9091f4b1d7b138ae50c26e1b4a5efbc"
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
