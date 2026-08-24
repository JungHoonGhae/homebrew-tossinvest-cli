class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.42.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.42.0/tossctl-darwin-arm64.tar.gz"
      sha256 "1c272ef03bffb77c004a1246c65f5bc4e6cd559558c4ee5471ce6bddc6fec325"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.42.0/tossctl-darwin-amd64.tar.gz"
      sha256 "3bb53649fae16e13153908a3b0a136a9d593815c283bdd61720fee146cfdf87c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.42.0/tossctl-linux-arm64.tar.gz"
      sha256 "3eee4b185a9dea6560ade01a9b9de9be24f8b465823388839ea7dfb32f8d2381"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.42.0/tossctl-linux-amd64.tar.gz"
      sha256 "ba5533857894cece5581f8359d44adb7080ae219f42de10af90d343adc1e4036"
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
