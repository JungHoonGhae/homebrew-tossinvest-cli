class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.1.3"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.1.3/tossctl-darwin-arm64.tar.gz"
      sha256 "ef85e7aea58f5f6059c89c7b9db1965c3c9cc6b852819a7113e9a4a9fd86857e"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.1.3/tossctl-darwin-amd64.tar.gz"
      sha256 "8cebe257d0f2fbf058d4050368bf72f9c21d17f5386f5e59010a6bf201ecfc21"
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
