class Urme < Formula
  desc "OCaml CLI orchestration layer for Claude + GitHub"
  homepage "https://github.com/corneliuhoffman/experience-agent"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/corneliuhoffman/experience-agent/releases/download/v#{version}/urme-#{version}-arm64-darwin.tar.gz"
      sha256 "0b5c7430d850d881677b33a0bc8a2ecb146e996f26b6bed7020103bdd4fe7fc2"
    end
  end

  on_linux do
    url "https://github.com/corneliuhoffman/experience-agent/releases/download/v#{version}/urme-#{version}-x86_64-linux.tar.gz"
    sha256 "223122fff207aeda38932682b15a19cb35b1174e0f14fcd7083297327f40a6ce"
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
