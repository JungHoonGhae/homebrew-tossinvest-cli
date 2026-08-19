class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.40.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.40.0/tossctl-darwin-arm64.tar.gz"
      sha256 "18435ca4d21aa733bdb04c0ceebc374bb94cb76cdd528ae302eb092d525349f9"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.40.0/tossctl-darwin-amd64.tar.gz"
      sha256 "815395d43fefdc344d35857edcdd2bd6ad636b3b1ad19913881e46644c279539"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.40.0/tossctl-linux-arm64.tar.gz"
      sha256 "4c4b22cc64710d3e8046a83c0c6678ed0b3de93bb2ea3bcbed1b250844e9c71d"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.40.0/tossctl-linux-amd64.tar.gz"
      sha256 "26e73f9eb33bcdb5e13bb55b0b06df402e5fa4f5f6b99c4920fabeca3041d7a3"
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
