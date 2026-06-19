class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.9.1"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.9.1/tossctl-darwin-arm64.tar.gz"
      sha256 "2a560491a1393cd8029f48ff07536cefae95a9e7b508049878a99bd84b19894e"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.9.1/tossctl-darwin-amd64.tar.gz"
      sha256 "1cacd51e93c7fb1820b7b4619891bdc1d51a08ae04a2c335ef64d268abbde4fa"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.9.1/tossctl-linux-arm64.tar.gz"
      sha256 "024b62222882f38e05ed288a81049bf769d82f4fafe85cce13cdfc8a11e8d3d9"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.9.1/tossctl-linux-amd64.tar.gz"
      sha256 "3bffad16dfecb4ca968aab5272b87cb2375b9c9e22266a2a6b44bacfdc08af78"
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
