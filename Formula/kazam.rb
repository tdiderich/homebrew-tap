class Kazam < Formula
  desc "Beautiful static sites from simple YAML — one Rust binary, no framework, no npm"
  homepage "https://tdiderich.github.io/kazam/"
  url "https://github.com/tdiderich/kazam/archive/refs/tags/v1.2.2.tar.gz"
  sha256 "a8e8cfaf3ecc7ceda7a447e1d96762c572e6c3bbd286118852e79b1a0c3b8fba"
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
