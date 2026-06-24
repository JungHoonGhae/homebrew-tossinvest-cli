class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.11.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.11.0/tossctl-darwin-arm64.tar.gz"
      sha256 "340185be45ff21ede67c6868c56c44be712f71af42214b850954abb9a037e704"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.11.0/tossctl-darwin-amd64.tar.gz"
      sha256 "ab43488e5010ad130d1e682504bec37931beaaf60bd808dfcb1c4216e7f257bf"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.11.0/tossctl-linux-arm64.tar.gz"
      sha256 "7234340739922f7adcb69a30e3c0efb12e971e87ce46038beb0a7d97980bdb22"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.11.0/tossctl-linux-amd64.tar.gz"
      sha256 "ad83c09ea16a56799dcb9d992a11d1111ae53a4cf4dab6cc9c78455394f6dabd"
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
