class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.1.7"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.1.7/tossctl-darwin-arm64.tar.gz"
      sha256 "634766d519d2f8dfca270ffa6f397682c07bc6773ae672eb1695dd48330a02dd"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.1.7/tossctl-darwin-amd64.tar.gz"
      sha256 "4af3c0daa695fa93f3e7253abf8b6e3708a134b43e14e06b744cd89dae86f407"
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
