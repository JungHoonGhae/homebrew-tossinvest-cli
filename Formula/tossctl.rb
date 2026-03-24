class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.3.3"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.3.3/tossctl-darwin-arm64.tar.gz"
      sha256 "afe183a23e3c53c3ee55898eeeea685570cf160579021afc20500153ddbf0155"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.3.3/tossctl-darwin-amd64.tar.gz"
      sha256 "5041f3ab9db81f9d3530f8b62bc62cd6058f871ff3964a1d0bb9ed392654d84b"
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
