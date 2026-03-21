class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.3.1"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.3.1/tossctl-darwin-arm64.tar.gz"
      sha256 "459a9ad1b39a541bacaa5e80271c82a7c949eeab26ddafb3e68ad34bce2d0b00"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.3.1/tossctl-darwin-amd64.tar.gz"
      sha256 "facb41b325e743f505e4cd47b0a090e7e4a030d3dda5fe320fb0377cf70cd27d"
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
