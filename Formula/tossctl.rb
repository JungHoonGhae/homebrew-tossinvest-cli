class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.36.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.36.0/tossctl-darwin-arm64.tar.gz"
      sha256 "9fbec914b586f0ae2364c35b5cac50acac80d39ff30c5b7b1060e48942ce0ddc"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.36.0/tossctl-darwin-amd64.tar.gz"
      sha256 "53cf0baadb3b7e165e4e5358420ee6d916f514a81995fa75327103e102c26391"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.36.0/tossctl-linux-arm64.tar.gz"
      sha256 "645870e854969c55897756bce4695b01047f7ddc6258a46abddf54505b7490ec"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.36.0/tossctl-linux-amd64.tar.gz"
      sha256 "dd16238311ad9a55dfab58898316dc0b8a82bd6846a2f418f9dde95bf9cddd7b"
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
