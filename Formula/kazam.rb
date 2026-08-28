class Kazam < Formula
  desc "Agent workspace and static site generator — one Rust binary, no dependencies"
  homepage "https://tdiderich.github.io/kazam/"
  url "https://github.com/tdiderich/kazam/archive/refs/tags/v1.24.0.tar.gz"
  sha256 "8af03b61dfbd3dc0ac1d12c0c35d546badfe9a8d9b9590b5f21aadb085506dcf"
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
