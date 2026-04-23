class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.4.4"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.4/tossctl-darwin-arm64.tar.gz"
      sha256 "cdb587d03816d5a6275f9f8cceab075695cc7df662b550c35a09eca2b0245b88"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.4/tossctl-darwin-amd64.tar.gz"
      sha256 "87b6e09094b15a2c3065b42e8d06b93d0890e256110164a95637af9974258e3e"
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
