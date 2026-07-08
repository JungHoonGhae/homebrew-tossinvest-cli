class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.21.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.21.0/tossctl-darwin-arm64.tar.gz"
      sha256 "b36dec25beb195e7161d27e12ffe8a27975ed745a0af6cca69df224d863a754c"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.21.0/tossctl-darwin-amd64.tar.gz"
      sha256 "4c377f0d456b314b63e0fc28bf5287aab0c1fe72a6a59d664fb3bb7804e81e25"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.21.0/tossctl-linux-arm64.tar.gz"
      sha256 "55837fb40e0222d571f1825d75d0c485170f795ebe8f8b8921221750f70ffb07"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.21.0/tossctl-linux-amd64.tar.gz"
      sha256 "03245997a00d7858a5ab2c8870886ef3e2f820a86d629aa0c0c78cf7d73810c1"
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
