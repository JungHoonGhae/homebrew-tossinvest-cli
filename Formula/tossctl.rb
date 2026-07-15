class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.24.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.24.0/tossctl-darwin-arm64.tar.gz"
      sha256 "ccea09679ead168a6231234dcb856ea36acd5464127a92b98881f53fb3e72861"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.24.0/tossctl-darwin-amd64.tar.gz"
      sha256 "77fa3886ad528a33735d9da7cf1bf904df925d972a4c1c86abd3b1c2a0ffd1ae"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.24.0/tossctl-linux-arm64.tar.gz"
      sha256 "8573e0f680939c64227e4c2659f5ee0f95319324fa1f1ee34ec8364e9cf3a274"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.24.0/tossctl-linux-amd64.tar.gz"
      sha256 "5b67aa10f1bb254368dd7b56a2d866dfe49670d0c65a2bc321c6ec0e11e3eba3"
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
