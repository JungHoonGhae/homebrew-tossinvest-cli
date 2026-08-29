class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.45.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.45.0/tossctl-darwin-arm64.tar.gz"
      sha256 "416b0fb05aeba4ab05711eddb9baf4db28afe8fc169bde92a837f6813d06504b"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.45.0/tossctl-darwin-amd64.tar.gz"
      sha256 "cd653b0802b9c6f15a79fc97189aff4b238aa9401ef853d715fff9193e39ceff"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.45.0/tossctl-linux-arm64.tar.gz"
      sha256 "ce635e5f552cc260ef54c526280d4fcc9a9c99c0c32ce05048ea7b1fd6825c2b"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.45.0/tossctl-linux-amd64.tar.gz"
      sha256 "d775e40e92f8894ac8867d16c90918d3e64240e65367881323186cb78bf3df57"
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
