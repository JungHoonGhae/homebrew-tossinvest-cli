class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.4.3"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.3/tossctl-darwin-arm64.tar.gz"
      sha256 "09098d34818e24a981024479aa216219947cb80a9a546d797c0081b131204ccb"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.3/tossctl-darwin-amd64.tar.gz"
      sha256 "99af50721170ddbfdbc14a9049de7c4fe52552f49c31d00e2066527ccc5f8e4e"
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
