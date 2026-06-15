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
  version "0.6.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.6.2/sazare-server-macos-arm64.tar.gz"
      sha256 "c03c50a7c7c653c75d63e9530813adb00db4480f262c38ec8624d303f3f20699"
    end
    on_intel do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.6.2/sazare-server-macos-amd64.tar.gz"
      sha256 "fee14ddfb596cacf01634866d5159a69a5a2d2a9b6da58c67397da983df8fb6c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.6.2/sazare-server-linux-arm64.tar.gz"
      sha256 "8b2bd83132881baecf73b6c24f35a4b39de859f5a555da465347c49fd16a63fa"
    end
    on_intel do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.6.2/sazare-server-linux-amd64.tar.gz"
      sha256 "776fc1b263ca8e92e30e8c763d2820e286d8c053c6acea1f719c911962f3c572"
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
