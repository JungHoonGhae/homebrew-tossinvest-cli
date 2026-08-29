class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.44.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.44.0/tossctl-darwin-arm64.tar.gz"
      sha256 "c9317f29d3faf5beae9b5ed0ce9942fec3ee3c9a3c822b0435b45a56a4a92e7d"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.44.0/tossctl-darwin-amd64.tar.gz"
      sha256 "e63e8ebea5449d6433feb20aebfecc13846f5483a08f967548a6077151ce013d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.44.0/tossctl-linux-arm64.tar.gz"
      sha256 "998e081854a2267b1c1fbd27343b7747c8af98cbe7a18a144a5052e9ea364c96"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.44.0/tossctl-linux-amd64.tar.gz"
      sha256 "795daa0aa6b7a45428e7499fe53306f378b84fbd09c8f41b96b9a5cd3ab71483"
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
