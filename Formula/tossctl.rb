class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.4.16"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.16/tossctl-darwin-arm64.tar.gz"
      sha256 "cd5c40e3216fb3b2192054a15132e9ba493b129440006d97ce5dfe5144e21064"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.16/tossctl-darwin-amd64.tar.gz"
      sha256 "6a8e79d4c482e9a9406feb3e5b8ba2c60b006d115825e2ab4fc77421e4b87d3e"
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
