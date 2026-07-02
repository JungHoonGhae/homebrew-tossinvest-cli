class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.15.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.15.0/tossctl-darwin-arm64.tar.gz"
      sha256 "1bd03498bb4923fc35b427f18320896c1ad5243ffa0973341ca1fc645766586d"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.15.0/tossctl-darwin-amd64.tar.gz"
      sha256 "9cfc1f558eee1de148580ca200ce949830a0cdc00203f577bf52dceab1a143c8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.15.0/tossctl-linux-arm64.tar.gz"
      sha256 "4e693e4e2627b2b528f76b7f5604810511e5ff10915e398e38e0eb633163e6cc"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.15.0/tossctl-linux-amd64.tar.gz"
      sha256 "d11924a7cec1b4d3f420699cf52a329fc94455dd74ae52155eb95052d5a4e109"
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
