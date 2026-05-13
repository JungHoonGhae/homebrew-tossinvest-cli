class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.4.11"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.11/tossctl-darwin-arm64.tar.gz"
      sha256 "877b223f70c80a08ba9962d123a6376a6ff1991b19f68614dd11cc2227888088"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.11/tossctl-darwin-amd64.tar.gz"
      sha256 "e14497950b72b7aa39678be665f0b7f3009c5226f5da20eb25b2adbb221e0c28"
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
