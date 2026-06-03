class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.5.1"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.5.1/tossctl-darwin-arm64.tar.gz"
      sha256 "c3bb737c5530d6034a28a009d27fe2356610b9a4ccf5cd330966ea674c9ff8aa"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.5.1/tossctl-darwin-amd64.tar.gz"
      sha256 "7a44575b3d161b01517abfe22ed392a94dee9ab41acb32116bc000755792eb90"
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
