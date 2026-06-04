class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.6.0"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.6.0/tossctl-darwin-arm64.tar.gz"
      sha256 "89444d877677221b22b0716e59f4abc489b1229ae27e30fd998f7326fcd1d9b9"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.6.0/tossctl-darwin-amd64.tar.gz"
      sha256 "a4edead27880fe7a99e3d9888a1baaab10c35cb27d8d42b774cf3f1e9957d6a5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.6.0/tossctl-linux-arm64.tar.gz"
      sha256 "05fee6e896a82a8f59bf649d02b996f6d050cd5adaaea3d49e2e1c85f2fbdcbd"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.6.0/tossctl-linux-amd64.tar.gz"
      sha256 "a0189037747ebe97c464b3bd261e3b376d583a4daa2d628479c39947317edf52"
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
