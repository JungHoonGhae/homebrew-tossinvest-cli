class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.26.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.26.0/tossctl-darwin-arm64.tar.gz"
      sha256 "ddc6f5c526410b5d2f991016ded08ab83f0301a32b02e91f55028bf6a848ca80"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.26.0/tossctl-darwin-amd64.tar.gz"
      sha256 "82dd727425b52b985dfe334489232680482fb0659de400dd31a2aab8769a45be"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.26.0/tossctl-linux-arm64.tar.gz"
      sha256 "1b93da3f1c20772f4d52343f7e3be923deba7aa6bc069aa170e006c389efeb12"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.26.0/tossctl-linux-amd64.tar.gz"
      sha256 "09104c5f1e1e34650c7432a075022c88c6526b80126c5bbf6148808b5a4f6aa4"
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
