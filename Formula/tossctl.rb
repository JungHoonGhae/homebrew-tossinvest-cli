class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.23.1"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.23.1/tossctl-darwin-arm64.tar.gz"
      sha256 "5cad809b33f742965f2a0db5bff5a83b70e0290bc48f8035d9f5714cf5380951"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.23.1/tossctl-darwin-amd64.tar.gz"
      sha256 "73bfa7299e7b5e43726d68a3b38d30915a26da56d8b8d4874af42cb4791c1b8e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.23.1/tossctl-linux-arm64.tar.gz"
      sha256 "74e9a5cdfee6ffec345fbdd0330ccefc81113ff950b535d501989594bbb223e0"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.23.1/tossctl-linux-amd64.tar.gz"
      sha256 "4f35d9f2db8a7d0484666b96c08b255fef80cf6177be9d62be5b4420c5c6b0bb"
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
