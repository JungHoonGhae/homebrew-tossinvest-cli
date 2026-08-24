class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.41.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.41.0/tossctl-darwin-arm64.tar.gz"
      sha256 "6202ad6a413c7da129492e555a940d700015ce971acd57da2d9617c774d1cddb"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.41.0/tossctl-darwin-amd64.tar.gz"
      sha256 "5645f7e9b10779290c33bed5d687b2484588c536a1e6538f8781444ca157e473"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.41.0/tossctl-linux-arm64.tar.gz"
      sha256 "a7ef9f923ceb237ce2f16c2fd058710e4a57cf85634f23f18831361fea206314"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.41.0/tossctl-linux-amd64.tar.gz"
      sha256 "951e3761414e8c7d8e81b8e832f9878cbe9bc71741d0bee6a9fb3a541430947b"
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
