class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.3.2"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.3.2/tossctl-darwin-arm64.tar.gz"
      sha256 "21a06452fabb5069a6a97d81b99f1b5134084faada1bd90c8193a14e3158e022"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.3.2/tossctl-darwin-amd64.tar.gz"
      sha256 "743e4107e336ff88d15db3377fb7ef05c4c38f48214adac3753b81a4fe9c3d13"
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
