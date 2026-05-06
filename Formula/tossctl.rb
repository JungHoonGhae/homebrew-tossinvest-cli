class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.4.6"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.6/tossctl-darwin-arm64.tar.gz"
      sha256 "d5cf8aa7b670e0e89d652410903c03a8407acb50d543f2699536e7c1653600cf"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.6/tossctl-darwin-amd64.tar.gz"
      sha256 "c6c401e2d5d25bbed6f57d6f007facbd3442957048e79dc7b5207f4946882d68"
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
