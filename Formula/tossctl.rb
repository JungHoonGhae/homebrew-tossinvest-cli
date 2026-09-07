class Tossctl < Formula
  desc "Unofficial CLI for Toss Securities web workflows"
  homepage "https://github.com/JungHoonGhae/tossinvest-cli"
  version "0.50.2"
  license "MIT"

  depends_on "python@3.11"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.50.2/tossctl-darwin-arm64.tar.gz"
      sha256 "2bbc4e8d19a27628154c962a8400041b164517da5a526b4cb9fe6058778ec591"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.50.2/tossctl-darwin-amd64.tar.gz"
      sha256 "98abc428f44a2dd31b8fc708d7a6acdde86b13d9b55f637568efc8c944cfdc8d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.50.2/tossctl-linux-arm64.tar.gz"
      sha256 "c096ddece5be62c564a70cd3a7e170eeaa7077d7212612c3d00f3bf759561156"
    else
      url "https://github.com/JungHoonGhae/tossinvest-cli/releases/download/v0.50.2/tossctl-linux-amd64.tar.gz"
      sha256 "e32f881798cbac2a5fb68caf777b672ce8a927dffc758b7272fc81b2ba90deb9"
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
