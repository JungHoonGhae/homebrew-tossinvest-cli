class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.54.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.54.0/tossctl-darwin-arm64.tar.gz"
      sha256 "ed58c5382c47ec9b6c0e71740fd63be77bc971003dae9e476b083c5b4c347651"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.54.0/tossctl-darwin-amd64.tar.gz"
      sha256 "b75b0e1498c0ec606a49f5191d5e3be696c9db2803a129b8c07da8386452f869"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.54.0/tossctl-linux-arm64.tar.gz"
      sha256 "b229811b17a71f9e51aa0f05b81f24b0c06684e4d2ac598d0aab46cf9787d24a"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.54.0/tossctl-linux-amd64.tar.gz"
      sha256 "a1e3d6bc083ea0c992c887f53029935f64ff6c9815a97b150e5006b21d425497"
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
