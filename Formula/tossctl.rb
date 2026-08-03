class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.35.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.35.0/tossctl-darwin-arm64.tar.gz"
      sha256 "e143ad0898b71ddcd79e1ca2bcf8630cb04cea3af3f6fc7535753c2ba5e71630"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.35.0/tossctl-darwin-amd64.tar.gz"
      sha256 "e190a1d56e7c68d7478f48cfbf4c3a448c7f367c7993ef67464b213b63df475f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.35.0/tossctl-linux-arm64.tar.gz"
      sha256 "94d98bba638e315dccae534ddf18121b5c61e26221fc84deaf99c8be3aea0cc9"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.35.0/tossctl-linux-amd64.tar.gz"
      sha256 "ddb8c2d0d789b81136fc8233d2a8175d90bce248c6cce278b75cc6b061339776"
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
