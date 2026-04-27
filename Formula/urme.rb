class Urme < Formula
  desc "OCaml CLI orchestration layer for Claude + GitHub"
  homepage "https://github.com/corneliuhoffman/urme"
  license "MIT"

  # urme shells out to git at runtime; everything else is bundled
  # into the tarball (macos: dylibbundler, linux: musl-static).
  depends_on "git"

  on_macos do
    on_arm do
      url "https://github.com/corneliuhoffman/urme/releases/download/v0.1.2/urme-0.1.2-arm64-darwin.tar.gz"
      sha256 "045afc46084e5106af1ed0716566930ebbf83dd3013a4697625c192fe93e143f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/corneliuhoffman/urme/releases/download/v0.1.2/urme-0.1.2-x86_64-linux.tar.gz"
      sha256 "b94acdb88f124c2456185ac19a6a3304eecba4ffdc9e3071d23d1416002367f2"
    end
  end

  def install
    # Both tarballs ship `urme` + `lib/` side-by-side. Install into
    # libexec so the binary's RPATH / @executable_path resolves the
    # bundled libs, then symlink into bin.
    libexec.install "urme", "lib"
    bin.install_symlink libexec/"urme"
  end

  test do
    assert_match "urme", shell_output("#{bin}/urme --help 2>&1")
  end
end
