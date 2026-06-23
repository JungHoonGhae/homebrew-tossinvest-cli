class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.10.1"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.10.1/tossctl-darwin-arm64.tar.gz"
      sha256 "c792a2be82b8f999d37040a8584ed1c9a47725264dcfd4c6e11220542122a471"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.10.1/tossctl-darwin-amd64.tar.gz"
      sha256 "ec0cc8e4978e3b5de8a625d256b2668b853ff069bef7a683f5f718463cefb7de"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.10.1/tossctl-linux-arm64.tar.gz"
      sha256 "26890b402a55cbe501496dce63d805cb2f47c3b19f1247677ba804a422f53ff4"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.10.1/tossctl-linux-amd64.tar.gz"
      sha256 "d0411968e96ba0881e3bc4b4c5740b171f6e2e448fd3f72d745dc121db7c579e"
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
