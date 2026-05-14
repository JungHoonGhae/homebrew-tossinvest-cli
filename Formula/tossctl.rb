class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.4.13"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.13/tossctl-darwin-arm64.tar.gz"
      sha256 "47aa3ea218737ea816779e40cdc8a1c37376a8224d0fabbbd2b95d258711ea2c"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.13/tossctl-darwin-amd64.tar.gz"
      sha256 "a56230b4305aac9f1a314a0a0cfdcf419574a42c58c88c651f415012129bcd4d"
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
