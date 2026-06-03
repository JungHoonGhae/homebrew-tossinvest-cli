class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.4.19"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.19/tossctl-darwin-arm64.tar.gz"
      sha256 "8e4197e87aceaff3618fce6f868f50c58c10837cb4e8b80795aea097c688908e"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.19/tossctl-darwin-amd64.tar.gz"
      sha256 "7976d884cd11a3dae9324931d2049a10c225cb8c7c415e560cb3b986ff9672a0"
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
