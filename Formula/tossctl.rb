class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.27.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.27.0/tossctl-darwin-arm64.tar.gz"
      sha256 "d095b651d92dcf5b69050748c07bfbfe82640be82af707522744f2cb1db2e5c9"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.27.0/tossctl-darwin-amd64.tar.gz"
      sha256 "ac5b07e0bb6bff9122f5c9efd78d48e7ac569d4e6fd952d1d540273823d1c758"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.27.0/tossctl-linux-arm64.tar.gz"
      sha256 "9f5dabbe5fe3be5dfad2cbbeba50351461ec46b57f0d89e8f744e8811d63c9a4"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.27.0/tossctl-linux-amd64.tar.gz"
      sha256 "5fc853cf2b1110a31875dbe1b89ed7b995707cbdca0ddbf12087f08b4ead7464"
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
