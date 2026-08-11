class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.39.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.39.0/tossctl-darwin-arm64.tar.gz"
      sha256 "dc891b5ae9450aeffad08b1bd0000811933a92c4982f1f6f52d6c02c81056837"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.39.0/tossctl-darwin-amd64.tar.gz"
      sha256 "1cf64da6792396cf1254c1b281853f4c413e2137ef9587305dfed66caad7d418"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.39.0/tossctl-linux-arm64.tar.gz"
      sha256 "bdd8c68577f0b50b2c139e56b0dbd2e49283127dc3fbcaebcd123d781a6209a2"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.39.0/tossctl-linux-amd64.tar.gz"
      sha256 "4c60dae93a32fbbb0ec670d9ea2c370ff574c7b3075bcb0d8cb7035278f2b5ba"
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
