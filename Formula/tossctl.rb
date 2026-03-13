class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.1.5"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.1.5/tossctl-darwin-arm64.tar.gz"
      sha256 "35f83da5327da9d042e11f3e4ea76463bc5ef94ceee8c1e14d5cd22ae370c199"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.1.5/tossctl-darwin-amd64.tar.gz"
      sha256 "3f52817f6ad3229d69e023797d4230b9bb05cc813d84f1b23992e125f628bad6"
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
