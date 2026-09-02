class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.49.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.49.0/tossctl-darwin-arm64.tar.gz"
      sha256 "bc9b868510ca7aee5a9a0aa3d599761489723efc34ef28dd58a533c2c80c30c5"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.49.0/tossctl-darwin-amd64.tar.gz"
      sha256 "06265b784811a90e4b6ff90b114d4551e64d9e0d65aa3f684be020292a9a1bd4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.49.0/tossctl-linux-arm64.tar.gz"
      sha256 "8890249a25323b76eefebb443aad01f22b2f028d0f41073bbd9f1a2f7f829b2d"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.49.0/tossctl-linux-amd64.tar.gz"
      sha256 "f89777d0196cc7bcfbb31eeb8dd0483cb42c1410e76ee2ac49876b48788a383b"
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
