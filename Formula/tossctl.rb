class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.4.15"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.15/tossctl-darwin-arm64.tar.gz"
      sha256 "fb25d803a00cde2016a990fd1e7e418a41fd470ea854359f32264cc3fd80f21a"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.15/tossctl-darwin-amd64.tar.gz"
      sha256 "4ebc7762d422a88c1655ca7052c58a4d288bddfd74c6180f45a100a65e08cbea"
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
