class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.50.3"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.50.3/tossctl-darwin-arm64.tar.gz"
      sha256 "4aa67e3fc6b2ef234fd0399d2889d66b281288d30736f7b871b6ee64343179f4"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.50.3/tossctl-darwin-amd64.tar.gz"
      sha256 "0c16f436be31fb5b162f8938c7a9429148c875b69fee2854694bd10f8f4ae011"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.50.3/tossctl-linux-arm64.tar.gz"
      sha256 "5c8a2aa3ee1d3fccf29681c0461e4514c5151191616014fba5700f58bd001afc"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.50.3/tossctl-linux-amd64.tar.gz"
      sha256 "949c2aa1d7bda8ea263e15d57d9a4b66ff8605e79959d238f0f8794231f3e96f"
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
