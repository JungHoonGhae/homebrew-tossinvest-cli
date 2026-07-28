class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.31.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.31.0/tossctl-darwin-arm64.tar.gz"
      sha256 "886004f110c8e0f7d937a95f52cf1578b81ae62833750c0be289f6ed90c3efaf"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.31.0/tossctl-darwin-amd64.tar.gz"
      sha256 "d82ad49e41f9dfc857d9c748974daa64c4967f608a3c3f3e5b61458815669b52"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.31.0/tossctl-linux-arm64.tar.gz"
      sha256 "80d8bd3e3c2f396990e070587fbd6249a2aeea39130a91acfb28ec87999fb24b"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.31.0/tossctl-linux-amd64.tar.gz"
      sha256 "9f1cfed73d2db694bcd316a3a41f67fd668b80e6337fab928d810ab83e5111ad"
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
