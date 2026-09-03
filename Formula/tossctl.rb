class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.50.1"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.50.1/tossctl-darwin-arm64.tar.gz"
      sha256 "048436b17a70faa133f2842fdd56de1f4f887ea87a75c21d5d790fed5b4380e1"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.50.1/tossctl-darwin-amd64.tar.gz"
      sha256 "4ca0b73794628b611f45c8f07bb11ef8f625e37fb5269bf08bbf9bb16d8ee9fc"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.50.1/tossctl-linux-arm64.tar.gz"
      sha256 "4d035ad0fd4a6cbaded4eb26d6d4485e734112f42371c5148ea55d3f882e7960"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.50.1/tossctl-linux-amd64.tar.gz"
      sha256 "192c0182f12ae737edaf45d447f040e0176398aec06298c27d6980d24387d12a"
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
