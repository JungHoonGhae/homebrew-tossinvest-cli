class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.4.17"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.17/tossctl-darwin-arm64.tar.gz"
      sha256 "9ce427a150b0a6ad49bc26ba2f8e529ef2a44387edb8cf30f900c6a12c841a66"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.4.17/tossctl-darwin-amd64.tar.gz"
      sha256 "50071a4637b8080a710da8803a800e86626dabe418ed973512bc2e26d59285f2"
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
