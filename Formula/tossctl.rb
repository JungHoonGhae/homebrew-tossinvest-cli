class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.51.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.51.0/tossctl-darwin-arm64.tar.gz"
      sha256 "4493a490149d1cbd4bf228a2a525c6a57d2f0f8cf8bbebb8272821a981da1f95"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.51.0/tossctl-darwin-amd64.tar.gz"
      sha256 "411aa9ea8f01e6658241a3206c2f0050a8728339a14897aa9ed984114840202f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.51.0/tossctl-linux-arm64.tar.gz"
      sha256 "7467a78fe91dd92e72024215ab9b267c65bc6f72222e272f1f994330b8d242b2"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.51.0/tossctl-linux-amd64.tar.gz"
      sha256 "c7978a7fc4954795e34f309ab436c1b8c7c1275fea880976581bc3db110bcc32"
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
