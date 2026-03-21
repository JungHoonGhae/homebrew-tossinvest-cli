class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.2.2"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.2.2/tossctl-darwin-arm64.tar.gz"
      sha256 "e93bf45892f0ae573de7cda5a16ec86820b617791037e20016d548096a3991c3"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.2.2/tossctl-darwin-amd64.tar.gz"
      sha256 "3585ab6dc5a075fe585fd2c7afadf1abb02d853d23d08034b4d895e068427058"
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
