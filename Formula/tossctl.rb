class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.23.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.23.0/tossctl-darwin-arm64.tar.gz"
      sha256 "ea98beda19a1a3475c8c6545b700f3e500c8831cdf51672f00303166004ff3ae"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.23.0/tossctl-darwin-amd64.tar.gz"
      sha256 "d45353e723950c33671149658a732d63721b3573a4d9d766345ab1cbeed688ea"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.23.0/tossctl-linux-arm64.tar.gz"
      sha256 "81a7a5f04fd30e5d7e8f8093907ed3c3406012d61cae9bcd1adebf9a1824c4ab"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.23.0/tossctl-linux-amd64.tar.gz"
      sha256 "6e96a6439492aa050e7ee16bbfebcede3a425ad6568ecd8b95c5c360255a6e92"
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
