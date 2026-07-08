class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.19.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.19.0/tossctl-darwin-arm64.tar.gz"
      sha256 "7bae3746df7ade52f726fc263d9c4dfe5ec009e8d5bb81dfbc22b8819489aad0"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.19.0/tossctl-darwin-amd64.tar.gz"
      sha256 "ece1555a60ba37dc37fa78331861ef4a7615b27b9fbfb6e225ccb58c0e8bc3f5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.19.0/tossctl-linux-arm64.tar.gz"
      sha256 "718d2a8196acb240ea2b3f4d5f683ab63ec1067ed24c33e4b6ae6b0a9e8af8e0"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.19.0/tossctl-linux-amd64.tar.gz"
      sha256 "c29d680845e51baa020513393f7a38aa7e911a11b1f05f88ade5e1fc78f839d3"
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
