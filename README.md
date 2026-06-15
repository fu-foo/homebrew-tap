# fu-foo/homebrew-tap

Homebrew tap for [fhir-sazare](https://github.com/fu-foo/fhir-sazare) — a
single-binary FHIR R4 server, the easiest way to run FHIR locally.

```sh
brew install fu-foo/tap/sazare
sazare-server --demo --open
```

Installing through Homebrew also avoids the macOS Gatekeeper "unidentified
developer" warning you get from a raw browser download: brew-installed binaries
aren't quarantined, so `sazare-server` just runs.

The formula tracks the latest [release](https://github.com/fu-foo/fhir-sazare/releases).
