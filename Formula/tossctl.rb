class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.57.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.57.0/tossctl-darwin-arm64.tar.gz"
      sha256 "916991357bbbb533cba28da0228b5c102ece7e7d38e4f1017d1b401c6e193ee0"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.57.0/tossctl-darwin-amd64.tar.gz"
      sha256 "d43247c1f78ba2bf59210aaef4973c3faaa3a961c5e5dcc34b8944ffcb9facc1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.57.0/tossctl-linux-arm64.tar.gz"
      sha256 "5675dbbcc3d3d0c195981ee4df904027e52d1efe20469978c44d53e8b083d4a8"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.57.0/tossctl-linux-amd64.tar.gz"
      sha256 "a31e98f66a932770b7717d60dfe36a4e81e41b06ff138ae377d944f487cb586a"
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
