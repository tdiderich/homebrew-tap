class Kazam < Formula
  desc "Beautiful static sites from simple YAML — one Rust binary, no framework, no npm"
  homepage "https://tdiderich.github.io/kazam/"
  url "https://github.com/tdiderich/kazam/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "ebe02e5b0ec770db30b15211b0012e8b64a138d91be0afeaa01d2b33d997662b"
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
