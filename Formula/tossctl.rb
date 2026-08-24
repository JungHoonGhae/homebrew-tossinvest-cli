class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.43.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.43.0/tossctl-darwin-arm64.tar.gz"
      sha256 "0cf6855d9e31fd71e68c650120c32e971970f4f517e75cba6fa4b4ba50ba09f6"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.43.0/tossctl-darwin-amd64.tar.gz"
      sha256 "5c3331b0c074ef4ab7ed1691d25010989f8a1a36e78dd09ff968cfd5d14e36d8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.43.0/tossctl-linux-arm64.tar.gz"
      sha256 "1af238511b0f86052f394f72c8b9e6c00808d125ab2d6d44b2ae6c9d42cfab85"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.43.0/tossctl-linux-amd64.tar.gz"
      sha256 "1d3ee0859832d28ed652b6aa5a1d3a50af7bf28678c2595d323164e09c033581"
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
