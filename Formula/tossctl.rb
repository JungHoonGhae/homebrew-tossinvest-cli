class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.4.18"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.18/tossctl-darwin-arm64.tar.gz"
      sha256 "9011dafcc4789a6498e1042d541e522c944df8b3d24c96a703824accf9e08a20"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.18/tossctl-darwin-amd64.tar.gz"
      sha256 "b3d56ec1bb29948a9605647e6abe06ad0b65568fa0356c17c4b0c9558e824a4c"
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
