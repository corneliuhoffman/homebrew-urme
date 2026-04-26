# homebrew-urme

Homebrew tap for [`urme`](https://github.com/corneliuhoffman/urme) — an OCaml CLI orchestration layer for Claude + GitHub.

## Install

```sh
brew tap corneliuhoffman/urme
brew install urme
```

## Cutting a release

1. In the [`urme`](https://github.com/corneliuhoffman/urme) repo, bump `version` in `urme.opam` and `Formula/urme.rb` (here), commit, then tag:
   ```sh
   git tag vX.Y.Z
   git push --tags
   ```
2. The `release` workflow builds `urme-X.Y.Z-arm64-darwin.tar.gz` and `urme-X.Y.Z-x86_64-linux.tar.gz`, uploads them to a GitHub release, and publishes the SHA-256 sidecars.
3. In **this** repo, edit `Formula/urme.rb`:
   - Update `version "X.Y.Z"`.
   - Replace each `sha256 "REPLACE_WITH_…"` with the matching SHA from the release page (or `cat urme-X.Y.Z-*.tar.gz.sha256`).
4. Commit and push. Brew users pick up the new version on `brew update`.

## Testing the formula locally

```sh
brew install --build-from-source ./Formula/urme.rb
brew test urme
brew audit --strict ./Formula/urme.rb
```
