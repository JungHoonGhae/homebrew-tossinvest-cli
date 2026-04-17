class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.3.6"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.3.6/tossctl-darwin-arm64.tar.gz"
      sha256 "2963871dab1c0882ee78c6a5b9ec11a5b908d5a5137a433e6744cc25ff849bce"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.3.6/tossctl-darwin-amd64.tar.gz"
      sha256 "3e22f6782e1db6bf3bac9b2649b9fb49249db8d61616f1f3133542ed3ae989ad"
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
