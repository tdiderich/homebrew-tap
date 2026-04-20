class Kazam < Formula
  desc "Beautiful static sites from simple YAML — one Rust binary, no framework, no npm"
  homepage "https://tdiderich.github.io/kazam/"
  url "https://github.com/tdiderich/kazam/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "cc510d78c8632109b96e9fc63bffeb95e90dbe04853e44de859742608b74b8cc"
  license "MIT"
  head "https://github.com/tdiderich/kazam.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "kazam", shell_output("#{bin}/kazam --version")
    system bin/"kazam", "init", "smoke-site"
    assert_predicate testpath/"smoke-site/kazam.yaml", :exist?
    assert_predicate testpath/"smoke-site/index.yaml", :exist?
    system bin/"kazam", "build", "smoke-site", "--out", "smoke-site/_site"
    assert_predicate testpath/"smoke-site/_site/index.html", :exist?
  end
end
