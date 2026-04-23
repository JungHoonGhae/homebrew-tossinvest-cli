class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.4.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.0/tossctl-darwin-arm64.tar.gz"
      sha256 "6b6f2f4778af242c6e1c20aafd80bde085a5ea4d12d0a9114b40407dfc415ea6"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.0/tossctl-darwin-amd64.tar.gz"
      sha256 "6539fa915e645abb8b8b5ec73f171c64d3f4d52d2784a9fd5e7724988930482c"
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
