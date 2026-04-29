class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.4.5"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.5/tossctl-darwin-arm64.tar.gz"
      sha256 "ece5f9d8d31d17474dc0ab23cf19e3b453ad4d482caec3eb80c33b67951852fb"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.5/tossctl-darwin-amd64.tar.gz"
      sha256 "36b1ac17bd045c7c58e8c45a13dbf1347f6c25b70824f0dc2e4ee67b39ca5884"
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
