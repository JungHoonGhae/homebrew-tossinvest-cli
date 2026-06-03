class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.5.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.5.0/tossctl-darwin-arm64.tar.gz"
      sha256 "39edc2aa9710c80f19709f411700091a945936053735698d5ff5318ac6b4cec3"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.5.0/tossctl-darwin-amd64.tar.gz"
      sha256 "367fde142b50ea25338d775f5f0422f7b91e5683e5c1f94432d21576bc3ade5f"
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
