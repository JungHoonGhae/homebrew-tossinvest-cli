class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.3.5"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.3.5/tossctl-darwin-arm64.tar.gz"
      sha256 "c835ab17826560d85c9b947e1a36d4c386bef0610b4ac820ba0892a96d34df23"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.3.5/tossctl-darwin-amd64.tar.gz"
      sha256 "20f951f2c2e84ed0e863e9239b420c5d098ff066d8aad67ba8dd5129b6f92881"
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
