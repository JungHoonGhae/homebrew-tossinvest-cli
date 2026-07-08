class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.22.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.22.0/tossctl-darwin-arm64.tar.gz"
      sha256 "10ec5cda642fae8df6b4c4583a5cb487f741946ee43d52bf4e7559358706afe9"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.22.0/tossctl-darwin-amd64.tar.gz"
      sha256 "9d3408ed2f81789e91193cab7613c43430f2cad0249c67f100999e5fef89bddc"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.22.0/tossctl-linux-arm64.tar.gz"
      sha256 "1512096bea169c63f45c967a85d11545dea5b63ac44f0efa584ccdbb613a9a37"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.22.0/tossctl-linux-amd64.tar.gz"
      sha256 "f4c2589717c3025cfa51fc5f1cc299d1bc61a6f61daef2eb3ac31750ccd07b4d"
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
