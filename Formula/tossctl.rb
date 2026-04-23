class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.4.1"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.1/tossctl-darwin-arm64.tar.gz"
      sha256 "462b4231a8dadc323c867bfadf89e8eb10059219c46306b8a30628adca97fb99"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.1/tossctl-darwin-amd64.tar.gz"
      sha256 "85b93cdbfbc2e403bc7ba5ffba58550391eebff357f197a38a594dd020a3915a"
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
