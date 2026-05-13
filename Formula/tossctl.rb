class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.4.10"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.10/tossctl-darwin-arm64.tar.gz"
      sha256 "d4c1140af79433b383279f3edcf2eee50f6b4c74f6b9cd1bfdef19e008b8bc55"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.10/tossctl-darwin-amd64.tar.gz"
      sha256 "839e3afb70bd1f5ead4702b8e56ac0109eb02c54ad69ff81dce390cdf8c14a00"
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
