# fu-foo/homebrew-tap

```sh
brew install fu-foo/tap/sazare     # single-binary FHIR R4 server
brew install fu-foo/tap/fugantt    # Gantt chart: plan against actual
```

[fhir-sazare](https://github.com/fu-foo/fhir-sazare) — the easiest way to run
FHIR locally.
[fugantt](https://github.com/fu-foo/fugantt) — plan against actual, counted in
working days.

Installing through Homebrew also avoids the macOS Gatekeeper "unidentified
developer" warning you get from a raw browser download: brew-installed binaries
aren't quarantined, so `sazare-server` just runs.

The formula tracks the latest [release](https://github.com/fu-foo/fhir-sazare/releases).
