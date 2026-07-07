class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.18.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.18.0/tossctl-darwin-arm64.tar.gz"
      sha256 "cf62fe1e2ddcf10e696bce8abb1dd40e2a86c479489fff787f8a7a8afbf2d4fa"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.18.0/tossctl-darwin-amd64.tar.gz"
      sha256 "cb367fa6bb596121921d24464ab6a2714f722be5d46c1c7e946ea4219e239ef6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.18.0/tossctl-linux-arm64.tar.gz"
      sha256 "4ac4eb868131b79be6c41cccac0ade20672fca1390b6d2665027235f13f840dd"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.18.0/tossctl-linux-amd64.tar.gz"
      sha256 "ee526be3be7c3a736f22c5951d5ac67134ae1a7e2240789c0b7f4279ea56e70e"
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
