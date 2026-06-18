class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.7.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.7.0/tossctl-darwin-arm64.tar.gz"
      sha256 "f8790c1c6ce3daada172f4bab5a2464d317bc9924f139ad478aa7d1769549431"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.7.0/tossctl-darwin-amd64.tar.gz"
      sha256 "defa1b88025b76227b228025e13fbbe46180302a340409a87511b02de47a9eef"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.7.0/tossctl-linux-arm64.tar.gz"
      sha256 "647b01edd58494e32fd0e8aff9884dae27c382d68e303cc3f829df300a15f423"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.7.0/tossctl-linux-amd64.tar.gz"
      sha256 "bb20069e1c9386aaf7516923bf67c8f6c9084d4875ae023a7d1cbf0fb08a7b13"
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
