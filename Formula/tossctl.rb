class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.1.1"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.1.1/tossctl-darwin-arm64.tar.gz"
      sha256 "82981cf32fa806282b785699335a0c82a7c70e9465a08d34612396cab71bdb26"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.1.1/tossctl-darwin-amd64.tar.gz"
      sha256 "00ef61f346e80aa7749fab6f819e218c0dfc02341fc7d572e2366665269c1317"
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
