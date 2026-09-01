class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.47.1"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.47.1/tossctl-darwin-arm64.tar.gz"
      sha256 "b798da0baef62fed61cf03181ab905cbe527db10b6d487cba2490ebd859fb349"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.47.1/tossctl-darwin-amd64.tar.gz"
      sha256 "db6348448513535107095945a2dce6c81dd7c9ab6dbef6c6c87d98b37b0e3772"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.47.1/tossctl-linux-arm64.tar.gz"
      sha256 "48d19eff738dbd89801263914ea913ff74f0c1375755964d5c889501cc243f94"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.47.1/tossctl-linux-amd64.tar.gz"
      sha256 "c759fe3497c8e2e004634484ab6ec882a0b099f18d475717ca0e59988d4da9b9"
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
