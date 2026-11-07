class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.57.1"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.57.1/tossctl-darwin-arm64.tar.gz"
      sha256 "3784154ce777d0e0010ea1ff836df4e6afed3ad140f90e1a6117aac6cba050b1"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.57.1/tossctl-darwin-amd64.tar.gz"
      sha256 "d2b3b45aa12022a90b1c2c3e49013599262d0aad9093b3871f75d0e091afeef2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.57.1/tossctl-linux-arm64.tar.gz"
      sha256 "52ae36d84c92205c0f989cebb04972d6d6aae8db1825e6317c933687755dcf74"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.57.1/tossctl-linux-amd64.tar.gz"
      sha256 "f8fe8b4d8f262896f36797868f9001882d243ec977de17bd8f0dc9e54e25c99f"
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
