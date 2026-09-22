class Kazam < Formula
  desc "Agent workspace and static site generator — one Rust binary, no dependencies"
  homepage "https://tdiderich.github.io/kazam/"
  url "https://github.com/tdiderich/kazam/archive/refs/tags/v1.28.1.tar.gz"
  sha256 "c3b11533f7c629fa113b0c56ccd4ebf7979bfcafea303c88b256392e5b1ca291"
  license "MIT"
  head "https://github.com/tdiderich/kazam.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "kazam", shell_output("#{bin}/kazam --version")
    system bin/"kazam", "init", "smoke-site"
    assert_path_exists testpath/"smoke-site/kazam.yaml"
    assert_path_exists testpath/"smoke-site/index.yaml"
    system bin/"kazam", "build", "smoke-site", "--out", "smoke-site/_site"
    assert_path_exists testpath/"smoke-site/_site/index.html"
  end
end
