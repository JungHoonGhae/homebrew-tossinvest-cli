class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.34.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.34.0/tossctl-darwin-arm64.tar.gz"
      sha256 "c8f9d8d36afa808b357321214d43d52819d27b6c26c234b6d7b38b3d17d4a2a2"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.34.0/tossctl-darwin-amd64.tar.gz"
      sha256 "3fb38932f99a8eb03e9c736563908b0b5b2d60b871059a392da6e0fc55b193ee"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.34.0/tossctl-linux-arm64.tar.gz"
      sha256 "c78b07595f152c32fed7066ad1d147eb937c5c75bb1f1e84cdd4535bb1264961"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.34.0/tossctl-linux-amd64.tar.gz"
      sha256 "da205834d63576c23978120e357db5173d3be512f64abf30c9d3a7c54a95bd31"
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
