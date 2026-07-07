class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.17.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.17.0/tossctl-darwin-arm64.tar.gz"
      sha256 "3a37dcde262fd2a2505ba3790d3d3e116261ecc2066a6a9ddfd78b621b17df61"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.17.0/tossctl-darwin-amd64.tar.gz"
      sha256 "40763647bb6f56278134df3e093ad2d0570cf21e3a10dd63a2b5991f7561eab1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.17.0/tossctl-linux-arm64.tar.gz"
      sha256 "40773d563b0096f7b97cf662bca4bcb0343facf32e6a16be15bf099d8a0bea91"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.17.0/tossctl-linux-amd64.tar.gz"
      sha256 "2e951b80f53f9ba18eff5634474219f4838a50b7a520ba4107d405b3b1a369bd"
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
