class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.11.1"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.11.1/tossctl-darwin-arm64.tar.gz"
      sha256 "1d642b02a3e6281ce1f2a85ca3ac91d89ba71f7ba2053b97db3ce99ad795f0e2"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.11.1/tossctl-darwin-amd64.tar.gz"
      sha256 "504deea52fbf319a1651243c07c26c8f42115abb2fa529dfb058f46b7fc891f2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.11.1/tossctl-linux-arm64.tar.gz"
      sha256 "520b98931474c30381a67b20e09db81e4996c7a8deaa8d6524ccb97f00712a93"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.11.1/tossctl-linux-amd64.tar.gz"
      sha256 "e1c9cb1a0c0b52de8c56954688e703c850926d0da573567feb7222975f30e325"
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
