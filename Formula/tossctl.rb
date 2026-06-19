class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.8.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.8.0/tossctl-darwin-arm64.tar.gz"
      sha256 "89f1d1b5b47c11e93be9dbeeffdcee67bd7eb08794d7f397db286ac9dcf4985f"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.8.0/tossctl-darwin-amd64.tar.gz"
      sha256 "1f964b21c0e3beb8458c9dadda87096b0420106b8225f4c741b51ae70fc39cc6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.8.0/tossctl-linux-arm64.tar.gz"
      sha256 "5524b2365a5d772d418964bbf6e7570dd6cb26fc2c53061a079997a33ad9eb6a"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.8.0/tossctl-linux-amd64.tar.gz"
      sha256 "d58d0163347e844d7a35291654be8411907ed1ade61fffa73f13107a3c66c204"
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
