class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.52.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.52.0/tossctl-darwin-arm64.tar.gz"
      sha256 "65be90e48b695ac93f7f25b1a2d1cfe2e1fe1aad9dceebe478fb5c406c6a8355"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.52.0/tossctl-darwin-amd64.tar.gz"
      sha256 "29e379c071e8ec7429f1395a519c7a3a59c2df4e2aebfd28a95e58235fefced2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.52.0/tossctl-linux-arm64.tar.gz"
      sha256 "3eeb93b8c96335d4a0505875bc9ed950d1326c67ad137be819e71867988bc0aa"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.52.0/tossctl-linux-amd64.tar.gz"
      sha256 "b205139878e9f8c46cd36c87c9a279f47030318afe1f969e816cfd8e813ea1a2"
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
