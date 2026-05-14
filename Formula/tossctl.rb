class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.4.12"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.12/tossctl-darwin-arm64.tar.gz"
      sha256 "55b19f9fdae93eabb0616fb0e5f37e8ccbc434850fac21f077cd873fefda3a4b"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.12/tossctl-darwin-amd64.tar.gz"
      sha256 "57e8b59e8fb275aa44233c04fca48790809bee9377a1f384da436870b7e50563"
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
