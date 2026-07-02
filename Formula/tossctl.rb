class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.16.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.16.0/tossctl-darwin-arm64.tar.gz"
      sha256 "577b78dfe9a8690c2cb03827dc47f49c721c1aaa550f8d9e4f1e8863b493253b"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.16.0/tossctl-darwin-amd64.tar.gz"
      sha256 "86278e24523ed50155e80ce41c0b786212e1846ec4f8c8b0f8cd0fecdc100ff7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.16.0/tossctl-linux-arm64.tar.gz"
      sha256 "b2954bc9f6130f5eb7fede1e73b556fff56b52c092d862b45c83c383348b8bc8"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.16.0/tossctl-linux-amd64.tar.gz"
      sha256 "fec1d6aab161f638cbfac412a89a901493223a6fd1b9812f6288f165e30e1f96"
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
