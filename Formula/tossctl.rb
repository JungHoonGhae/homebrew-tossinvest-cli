class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.38.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.38.0/tossctl-darwin-arm64.tar.gz"
      sha256 "268a1880ac323aa9b55aa355b94309ef09675b3a5b1e6bba091cf715df041bbc"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.38.0/tossctl-darwin-amd64.tar.gz"
      sha256 "213a0fc0471ed4fb294be382d2a3e87c08aa00bd11e104a75b85d62de00b5517"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.38.0/tossctl-linux-arm64.tar.gz"
      sha256 "b38084a077a4240a937c15f0a891641144c1730b0cb3e475ad9133a2456e4bb5"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.38.0/tossctl-linux-amd64.tar.gz"
      sha256 "c7d3334afc22e52cd1ea33e2b05c0e4309f2b1073caadaf268fd865dc3cf53e7"
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
