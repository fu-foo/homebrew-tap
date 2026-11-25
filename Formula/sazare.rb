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
  version "0.11.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.11.0/sazare-server-macos-arm64.tar.gz"
      sha256 "7b55d5b99481995c5971ca15e1377a45154465b6b6e98b7a150f07ab785fb9e1"
    end
    on_intel do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.11.0/sazare-server-macos-amd64.tar.gz"
      sha256 "a23d35201da0358bd05d7249b23d69d70bf78ee641a0962cfa862feda84c5da4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.11.0/sazare-server-linux-arm64.tar.gz"
      sha256 "4309c7890894a408a6c7148a50fa5362c35f4191141711a232e663ed87858c59"
    end
    on_intel do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.11.0/sazare-server-linux-amd64.tar.gz"
      sha256 "495ac396649c8e4c2043e96485867d26e2aa47c6b3c802d7489d5b1c76e02c6d"
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
