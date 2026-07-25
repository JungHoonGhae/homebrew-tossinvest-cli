class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.28.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.28.0/tossctl-darwin-arm64.tar.gz"
      sha256 "c72c6bd38348969ebaacb857cff7dba3941c8a2b928ce7314a5a5941eb27fc38"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.28.0/tossctl-darwin-amd64.tar.gz"
      sha256 "c0554897d2f472aee0086b03345f51b0d31c41ebf63fdb0c481d5629e4026deb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.28.0/tossctl-linux-arm64.tar.gz"
      sha256 "69fdcd3ba60821ff1a4b80d83c88b0c1ffc22bb5bbe1a373af7bf52b3c15194c"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.28.0/tossctl-linux-amd64.tar.gz"
      sha256 "59737062782c92fafdf0914e6a913af15fedc8653daa8227e81f6e4cb438e3f1"
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
