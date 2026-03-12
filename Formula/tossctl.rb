class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.1.2"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.1.2/tossctl-darwin-arm64.tar.gz"
      sha256 "d992c247348babb7b26cb4bb60795b26259c296ad14724031c22a64e2c1aedfd"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.1.2/tossctl-darwin-amd64.tar.gz"
      sha256 "033618fc8a836f9278034a43f7a0165cb7cb4106fc136f95533ad5cc6a5b908b"
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
