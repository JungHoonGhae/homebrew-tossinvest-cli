class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.2.3"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.2.3/tossctl-darwin-arm64.tar.gz"
      sha256 "b18a172f591f81a64ff77ba4712b24f24590986033c3bb87af461621fee560a3"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.2.3/tossctl-darwin-amd64.tar.gz"
      sha256 "0df0bfa9686494edab45fb63dd63808d2e8586a18be79836b27716c5fce42ed2"
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
