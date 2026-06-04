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

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.5.1/tossctl-linux-arm64.tar.gz"
      sha256 "8bcdbf7a1fdbaffc55848a3b40445561e73d185713ceb6ce4f82ce4dfd4ff471"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.5.1/tossctl-linux-amd64.tar.gz"
      sha256 "8f6115ed6c12b0d825e696c6e8a84b2efa4ac916f579fe6d02737564db012c66"
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
