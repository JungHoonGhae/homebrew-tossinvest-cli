class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.20.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.20.0/tossctl-darwin-arm64.tar.gz"
      sha256 "9bda958cf5c22ec2b7dfd52939ada42aaee7696b0796e793979b6f6e04e39cfe"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.20.0/tossctl-darwin-amd64.tar.gz"
      sha256 "4c8709c283ce2e01a9c60b3cde02aceeaa1bc33d2707b0e9877e151f52f66b70"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.20.0/tossctl-linux-arm64.tar.gz"
      sha256 "69d79478ab931b633b59fcc0cccff418a7b45564fb1a11a8f0a5c21c74bad937"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.20.0/tossctl-linux-amd64.tar.gz"
      sha256 "920ce370f48bcfc51c2cda6084e7a36a1d3097864a933084e7197b8b9028a480"
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
