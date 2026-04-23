class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.4.2"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.2/tossctl-darwin-arm64.tar.gz"
      sha256 "2990f0962911bc85e5091eab7253b656ba87cff5a5bdde5bc2ff647f08056cf9"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.2/tossctl-darwin-amd64.tar.gz"
      sha256 "dcd672454dd79a1b1092d2f1696c22d32b39c7719d717755c58040f412001cef"
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
