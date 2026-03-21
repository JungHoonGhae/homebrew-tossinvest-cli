class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.3.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.3.0/tossctl-darwin-arm64.tar.gz"
      sha256 "701ea8c5d9ba226c57a1577765cf53cffafdf6afd37c98105c9aa05b3b298853"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.3.0/tossctl-darwin-amd64.tar.gz"
      sha256 "2571f12a1d96b3868bb383dcede432ebc2523c62c6846982db0faa0791662843"
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
