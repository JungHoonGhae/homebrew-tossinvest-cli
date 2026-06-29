class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.13.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.13.0/tossctl-darwin-arm64.tar.gz"
      sha256 "72d20f9709087a979360d38d881f3c67d05428ff378687f54cb286b2763b11dd"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.13.0/tossctl-darwin-amd64.tar.gz"
      sha256 "204fc6bbdf1c436dfa32acf8930c15e596fa94cd42530d281feefcb4b2cf1aba"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.13.0/tossctl-linux-arm64.tar.gz"
      sha256 "7be85b45d889f223314104c47a109ac30351d51bc0524cd3fba1d720e033befa"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.13.0/tossctl-linux-amd64.tar.gz"
      sha256 "5e94facd6d881b37e184b6acafbdd4d437b05c753ae7a91f8886eda95b39b077"
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
