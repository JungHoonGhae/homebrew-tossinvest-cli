class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.29.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.29.0/tossctl-darwin-arm64.tar.gz"
      sha256 "e01046002f801e73ccbb7ab51aa54d68446e4a82d0903d90bc53a09bed3b5e96"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.29.0/tossctl-darwin-amd64.tar.gz"
      sha256 "a062716160bdf17918d052fdee8a3cffcacd1f7cddc2a43a37530bce69fd00ea"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.29.0/tossctl-linux-arm64.tar.gz"
      sha256 "3c93a3dec8c1a831017758d26329678b6691a89e154120173b4bd966b59a9c1b"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.29.0/tossctl-linux-amd64.tar.gz"
      sha256 "d9862d9a402b8a0551e6b604866e3009fb5f8d195181c5bca15bf560ba2c7b47"
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
