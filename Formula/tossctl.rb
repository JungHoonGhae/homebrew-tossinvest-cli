class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.54.1"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.54.1/tossctl-darwin-arm64.tar.gz"
      sha256 "6699fb47dc73b578bb815957e4d5d9520670a3a3c7190f9871df1b24b4716a97"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.54.1/tossctl-darwin-amd64.tar.gz"
      sha256 "39246665f43a891f23803a4058fe4115f246259507aa3c2ea7bcb84cb493143d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.54.1/tossctl-linux-arm64.tar.gz"
      sha256 "aa428a8a5a9dcd31581356dfc49d29e2b89b72abde0a613184100852dfe7a231"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.54.1/tossctl-linux-amd64.tar.gz"
      sha256 "e6ee4265af13f19803c0bf8ca82ed10d22510ea0a0ff1c377671b3bff42294ff"
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
