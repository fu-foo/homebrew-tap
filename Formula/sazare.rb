# typed: false
# frozen_string_literal: true

# Homebrew formula for fhir-sazare — a single-binary FHIR R4 server.
#
# Installing via Homebrew also sidesteps the macOS Gatekeeper "unidentified
# developer" dialog: brew downloads aren't quarantined the way a browser
# download is, so `sazare-server` runs without the "move to trash" prompt.
class Sazare < Formula
  desc "Single-binary FHIR R4 server — the easiest way to run FHIR locally"
  homepage "https://github.com/fu-foo/fhir-sazare"
  version "0.6.6"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.6.6/sazare-server-macos-arm64.tar.gz"
      sha256 "b4077e57abf5b958ab97451c7b1057512c324b1e51a078dc215e191522179437"
    end
    on_intel do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.6.6/sazare-server-macos-amd64.tar.gz"
      sha256 "6bdef36ecc800911a53beeea084cd0e3739aab60e8e9bcadc386a82ccb91379b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.6.6/sazare-server-linux-arm64.tar.gz"
      sha256 "55f7182856d3ae05cb3de34c613a43afea6c6b649429f70fa1433d63eea08242"
    end
    on_intel do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.6.6/sazare-server-linux-amd64.tar.gz"
      sha256 "f68282ccef7a45d886a004f68f96cd843b30cc6e9134f513333c660ca046c914"
    end
  end

  def install
    bin.install "sazare-server"
  end

  test do
    port = free_port
    pid = fork do
      ENV["SAZARE_PORT"] = port.to_s
      ENV["SAZARE_DATA_DIR"] = testpath/"data"
      exec bin/"sazare-server"
    end
    sleep 5
    assert_match(/ok|UP|healthy|"status"/i, shell_output("curl -fsS http://127.0.0.1:#{port}/health"))
  ensure
    Process.kill("TERM", pid) if pid
  end
end
