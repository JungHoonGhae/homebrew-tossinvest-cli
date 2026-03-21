class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.1.6"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.1.6/tossctl-darwin-arm64.tar.gz"
      sha256 "3f94d0b9c0c4cd24dec0ace58f084b4fd3626125f690e0cd1834a5fadcb78568"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.1.6/tossctl-darwin-amd64.tar.gz"
      sha256 "45d77a04b805455b2357115b09aafce5ac4395ce6cdea70a9cbc3e882711ab5d"
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
