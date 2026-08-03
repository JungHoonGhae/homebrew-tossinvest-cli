class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.32.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.32.0/tossctl-darwin-arm64.tar.gz"
      sha256 "fd65b783e4b443153af5f530f21dd0b051a27e9fc08c65150484f8f7936f5dd8"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.32.0/tossctl-darwin-amd64.tar.gz"
      sha256 "1692520cb599a6211675307484617b34dd1222b348db40377da8acd3108bb97d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.32.0/tossctl-linux-arm64.tar.gz"
      sha256 "928c5e08cd333a9f5ccd3926b116c052955160dabd2eb78be9d7a9b72d29f96a"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.32.0/tossctl-linux-amd64.tar.gz"
      sha256 "43d138dc257c8462f37cfa6b60887361ed421d3e92240f0f0c4fe8d9bb62c3a5"
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
