class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.50.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.50.0/tossctl-darwin-arm64.tar.gz"
      sha256 "ca9837b9eb9426fce93ee700f5d60d61d173e1dad64ca2b0f4a4c7d81fb22b87"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.50.0/tossctl-darwin-amd64.tar.gz"
      sha256 "9a5c7fc0731cd324e14e59d89287c2bc30283aae232ad6c0e084d02382a78856"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.50.0/tossctl-linux-arm64.tar.gz"
      sha256 "973e35aea29369f417c18851337eacc8f8668a205ad3a3324e5515e25fdbc9ce"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.50.0/tossctl-linux-amd64.tar.gz"
      sha256 "6275bd9689945de856d0515568761d0030a5e2e925332b858456c198ff2b0862"
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
