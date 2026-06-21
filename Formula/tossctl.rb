class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.10.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.10.0/tossctl-darwin-arm64.tar.gz"
      sha256 "b50580113d26f38f77308e5d7ebefe5d07656b1fd2cb73911efba8bc04f9f69e"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.10.0/tossctl-darwin-amd64.tar.gz"
      sha256 "93d7b908f7fb0a207d538f43eaac38f87bd53d35818c2e33d7ad684541b8854a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.10.0/tossctl-linux-arm64.tar.gz"
      sha256 "42518412f442538bdeee4a10574a5892b92fa4569e039cad2bd85b39064ce1e6"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.10.0/tossctl-linux-amd64.tar.gz"
      sha256 "c2451f9a19bd584be345c75d32b39a47ce26759738f56e44fd3032ad0b3e6bc2"
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
