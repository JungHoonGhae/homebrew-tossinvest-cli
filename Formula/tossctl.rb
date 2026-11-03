class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.55.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.55.0/tossctl-darwin-arm64.tar.gz"
      sha256 "ec2f47b01af0d36fd8f289fd6a66f89dc22219d865991e996372c2b155be1677"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.55.0/tossctl-darwin-amd64.tar.gz"
      sha256 "784a0456d46d93df24687ba61929e1bf5d5463492b915c23819ad3c9088be2d5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.55.0/tossctl-linux-arm64.tar.gz"
      sha256 "b67ee9c0f7353ea1ed9221ef7a9447ac7275b22db8f3d7b84ab748e89da0a093"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.55.0/tossctl-linux-amd64.tar.gz"
      sha256 "2c4f9146d7463786c9642fbbef40c31a0b9bf32eefe6d1145ff4ac004a6ca004"
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
