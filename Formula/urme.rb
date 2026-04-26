class Urme < Formula
  desc "OCaml CLI orchestration layer for Claude + GitHub"
  homepage "https://github.com/corneliuhoffman/urme"
  version "0.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/corneliuhoffman/urme/releases/download/v#{version}/urme-#{version}-arm64-darwin.tar.gz"
      sha256 "7aee7a40e749a45230c345e77803d773c73217ad6cca87833695510363b307e1"
    end
  end

  on_linux do
    url "https://github.com/corneliuhoffman/urme/releases/download/v#{version}/urme-#{version}-x86_64-linux.tar.gz"
    sha256 "1443055b53e005ee3089c69dcd76f74a6418cdcc3c3f3d45d5471144f145250c"
  end

  # urme shells out to git at runtime; everything else is bundled
  # into the tarball (macos: dylibbundler, linux: musl-static).
  depends_on "git"

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
