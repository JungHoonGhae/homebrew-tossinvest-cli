class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.12.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.12.0/tossctl-darwin-arm64.tar.gz"
      sha256 "4f38edaec571c8c31716d2f9b884b6e0c611c43d529b0e1d6009d741e814bb4f"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.12.0/tossctl-darwin-amd64.tar.gz"
      sha256 "385ee216cd6200761a9f059e6e32bec2791199747015e7d22b0cf35f1255be25"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.12.0/tossctl-linux-arm64.tar.gz"
      sha256 "db3dd9d4bae203c8cb73b5b2d6415eba1d842db3cd5ee5195ee6cd856778bb5d"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.12.0/tossctl-linux-amd64.tar.gz"
      sha256 "0848375062370bcfcf5aead43225b25feb1a48a5efad862aa7e253daefed821c"
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
