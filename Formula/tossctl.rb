class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.9.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.9.0/tossctl-darwin-arm64.tar.gz"
      sha256 "b79c8b3526a7ed50b9c27b86a9d078879fdb3bbfbd8dcb324ab2e5f981da9475"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.9.0/tossctl-darwin-amd64.tar.gz"
      sha256 "9eaf03ee3e7267738213d2ce570fc2d35e97a1e3e9287766c6567e863addd1ee"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.9.0/tossctl-linux-arm64.tar.gz"
      sha256 "10fb4f9f9c9018df8700ddd0fab6bf734b78224db5463825e62e94bcc2413d9e"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.9.0/tossctl-linux-amd64.tar.gz"
      sha256 "4f0393caef3e9ac49a9dfd7310d9139712b211b86d58d1da7668bbc1e44c627b"
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
