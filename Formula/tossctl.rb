class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.52.1"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.52.1/tossctl-darwin-arm64.tar.gz"
      sha256 "b648b3589c51f8657355f56450bc19707afad857eaf6233dd48004ebf9d3c60b"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.52.1/tossctl-darwin-amd64.tar.gz"
      sha256 "f82f3e7ff9f56e31751fa35f2f7479de29f37303ab6be2d9bfc7dd51303bba73"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.52.1/tossctl-linux-arm64.tar.gz"
      sha256 "453952277a5ff8e263b9c366dafca83966e8ca0e5ea876d3cb1fe69ce07869e2"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.52.1/tossctl-linux-amd64.tar.gz"
      sha256 "0fe232550d954f113bec6a2a8e70cb22c10fbe2d285fff1ab0b6942f0bda34d9"
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
