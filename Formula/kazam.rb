class Kazam < Formula
  desc "Agent workspace and static site generator — one Rust binary, no dependencies"
  homepage "https://tdiderich.github.io/kazam/"
  url "https://github.com/tdiderich/kazam/archive/refs/tags/v1.28.0.tar.gz"
  sha256 "c2f6a98a4272e0311611c14eda352a2ac3c0a143df171b67af7da4d5192ca3c3"
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
