class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.20.1"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.20.1/tossctl-darwin-arm64.tar.gz"
      sha256 "300d3abd8270cbdd5cedbb224f4cf096a3db6baa0befe4e19d7b752519e0aba7"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.20.1/tossctl-darwin-amd64.tar.gz"
      sha256 "cb6c8643db5d8d72b9d70a64d346752728595793f6148810057ce9da0ae446fe"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.20.1/tossctl-linux-arm64.tar.gz"
      sha256 "3422cd60a2ef7ce4ac1861ff01a819dd24295a835a811fd7e7f3bdff88538584"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.20.1/tossctl-linux-amd64.tar.gz"
      sha256 "223a4fefa5822a2a9fa9c6054077f90279c570875ca4cf98c821e7e77e932df9"
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
