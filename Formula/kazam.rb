class Kazam < Formula
  desc "Beautiful static sites from simple YAML — one Rust binary, no framework, no npm"
  homepage "https://tdiderich.github.io/kazam/"
  url "https://github.com/tdiderich/kazam/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "40dae573058836f030d60136973e46e66af6ae88e22971e3ce27bd963a775fd4"
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
