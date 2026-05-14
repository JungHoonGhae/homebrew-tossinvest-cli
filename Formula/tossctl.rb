class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.4.14"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.14/tossctl-darwin-arm64.tar.gz"
      sha256 "186da49a1c44883b89de1a907533e92dab490c5c39d08fba4c0c5ab23c24751e"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.14/tossctl-darwin-amd64.tar.gz"
      sha256 "830cf1b4d998b64a8dff8946683322f409844bafcb63cdc662d7ec9dffc24104"
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
