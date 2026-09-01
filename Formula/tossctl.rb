class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.47.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.47.0/tossctl-darwin-arm64.tar.gz"
      sha256 "6c2536d50c173cce2fc6d6ff5baa050c77bc090b6195ecf0fffb811f517f21bd"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.47.0/tossctl-darwin-amd64.tar.gz"
      sha256 "3624d8594a306bc421d1e3dd94692335829c663666dca62f16ee5b3889c9d90a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.47.0/tossctl-linux-arm64.tar.gz"
      sha256 "4ef1579bb55239fd30a40d34465a60babd1347dc4e1d92c29e86eb53e7ec62f5"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.47.0/tossctl-linux-amd64.tar.gz"
      sha256 "1db729a1e4a6d743ed638fb7df90d78c1828f2f22eaa4314f7276afa676a809f"
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
