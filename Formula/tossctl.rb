class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.56.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.56.0/tossctl-darwin-arm64.tar.gz"
      sha256 "26e69ac693645e2356346710afddebb31e2f4c47d514e1a3627b844d8aec56ad"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.56.0/tossctl-darwin-amd64.tar.gz"
      sha256 "4852e412ca555846e04029dd6d561261aa71a944091dcca8345618620ad163c1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.56.0/tossctl-linux-arm64.tar.gz"
      sha256 "7d493200bdd6f7ea947c9cfd2ad587470888d449297519f67f00f3acfef0ca3d"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.56.0/tossctl-linux-amd64.tar.gz"
      sha256 "ab3af17872feb9dc4262db66fa132eff235d060e8c7fcc50c6e3ec0c5e7e6928"
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
