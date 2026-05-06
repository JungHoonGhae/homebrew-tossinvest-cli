class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.4.7"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.7/tossctl-darwin-arm64.tar.gz"
      sha256 "48c5d216cb209afaed206486ca3365f8cf5c8b9f6a8fac410a7d09d17c80fcde"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.7/tossctl-darwin-amd64.tar.gz"
      sha256 "3a0d4f6ebfc7539d8bbf1b532b4641619ba7fa1ffd8df6410d33f77f975612cb"
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
