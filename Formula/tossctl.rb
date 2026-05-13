class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.4.8"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.8/tossctl-darwin-arm64.tar.gz"
      sha256 "121907ea3df9a490171b79f29abe597c25250c8abda64803a1c8c8ad2249048e"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.8/tossctl-darwin-amd64.tar.gz"
      sha256 "b10b11cbb41a91ef8003e65c9182f5ee763a69ddf3346a9057add898b6a5fa7b"
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
