class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.33.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.33.0/tossctl-darwin-arm64.tar.gz"
      sha256 "9a7886f4a6dc687fdd828e037f470acb8056f77a8dff55fdbe4c77d5edb10515"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.33.0/tossctl-darwin-amd64.tar.gz"
      sha256 "8df448144b6f90e205047b8a926a3fda6de22d9a8d60518e4e700113a6abc801"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.33.0/tossctl-linux-arm64.tar.gz"
      sha256 "20c6877ade9088f7f5470e4c81ee63a0037a937c0f055329c6986fd73a2bc236"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.33.0/tossctl-linux-amd64.tar.gz"
      sha256 "6c666799deee1292272ae69d9af8a038698904e9255af885939342348b666bd1"
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
