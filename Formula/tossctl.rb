class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.30.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.30.0/tossctl-darwin-arm64.tar.gz"
      sha256 "e26853d09a736ea6f995e5c9de816bbeba05805e592e178d946d5b608dd0293d"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.30.0/tossctl-darwin-amd64.tar.gz"
      sha256 "7beeaa04987507efed83aec804b7243d5e5fb1b821f80a48d1a095c5dd7bce75"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.30.0/tossctl-linux-arm64.tar.gz"
      sha256 "b2a3de1b2a6684838c33532e3f81fc988a290dda2568ea88c96e401a5683390c"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.30.0/tossctl-linux-amd64.tar.gz"
      sha256 "74ec87dbf9d6fb60c440c2f119eeaa62e51590057e9c2e8ecfbe28391e471a41"
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
