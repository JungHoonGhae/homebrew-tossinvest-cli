class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.2.1"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.2.1/tossctl-darwin-arm64.tar.gz"
      sha256 "98bf85da298e0190e83413693bafb0d2ad6a7b6ea373eecf62437cd29d5ca8e5"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.2.1/tossctl-darwin-amd64.tar.gz"
      sha256 "c2c590211d9d3f77edcc5b76970ec3d8d4cde2ba0d7ed51b87c84d268f026135"
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
