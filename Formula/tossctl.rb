class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.4.20"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.20/tossctl-darwin-arm64.tar.gz"
      sha256 "b5823c06973ccd9a2650cfa045e323c400f6aef9ae7c4a8f8737b6fbb7dbd9ae"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.20/tossctl-darwin-amd64.tar.gz"
      sha256 "de5d7159ff34b2315ccaf4435f060b698da2f5e259b1c63df96e002205c304d9"
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
