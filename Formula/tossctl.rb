class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.5.2"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.5.2/tossctl-darwin-arm64.tar.gz"
      sha256 "d86fb704c30643af2d8526f18529744f9420b3b9651a30ef5868e46eaf610ab4"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.5.2/tossctl-darwin-amd64.tar.gz"
      sha256 "d5a3271130466b93d4bf634588326fe4310e194f7104fa68ac7dd7e866032d60"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.5.2/tossctl-linux-arm64.tar.gz"
      sha256 "8c599418f5aca80f94f5d60275dab1dd020bdf579a795c5d24b047074ee49515"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.5.2/tossctl-linux-amd64.tar.gz"
      sha256 "7dc7550071e928efeefbd9b030c4117d838760925171561616a9b69311af2072"
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
