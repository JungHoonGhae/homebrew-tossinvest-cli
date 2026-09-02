class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.48.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.48.0/tossctl-darwin-arm64.tar.gz"
      sha256 "002e545bc15a9a24cfe59b7326360b686921fa50f920e745714fa3621091e480"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.48.0/tossctl-darwin-amd64.tar.gz"
      sha256 "bcf90f9baf78daa11441bb2b1c04086521baf7297dbb078a9f40acb16e64c238"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.48.0/tossctl-linux-arm64.tar.gz"
      sha256 "37a2d42b2951bacf8a72a2fe11420bff1a9393e1015732297915e858371905e6"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.48.0/tossctl-linux-amd64.tar.gz"
      sha256 "764ade76bee5d4ae380742616d94aa5ed00536e99c8bf21634e234d85ef61999"
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
