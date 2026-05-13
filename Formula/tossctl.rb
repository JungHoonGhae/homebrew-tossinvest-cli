class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.4.9"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.9/tossctl-darwin-arm64.tar.gz"
      sha256 "a3bc75142a46bb323d95f9e6175efa63757c8238b2edb5c3e16fd8dde9781213"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.9/tossctl-darwin-amd64.tar.gz"
      sha256 "4e27b785d40989ecd67f191a275bee97a030cab4b49bdd27e6091843bb0df581"
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
