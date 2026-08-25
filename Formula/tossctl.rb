class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.43.1"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.43.1/tossctl-darwin-arm64.tar.gz"
      sha256 "e9c5a875688e6233cb362b02e0e849a7ddc0db609c2efbc27e4008fbf5dec8b7"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.43.1/tossctl-darwin-amd64.tar.gz"
      sha256 "d5628953aae263ec33192e96282bfc32564467469cf3eee334f32ab143dd682e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.43.1/tossctl-linux-arm64.tar.gz"
      sha256 "a49605d54fa7d79acfd279bd16efafbd0d64656cb6002011adcec11a22cc6591"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.43.1/tossctl-linux-amd64.tar.gz"
      sha256 "4969d8bd41e9683b58c44440b03ae4b5d6a394445f370ff7dec4e75944a77a6d"
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
