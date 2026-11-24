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
  version "0.10.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.10.0/sazare-server-macos-arm64.tar.gz"
      sha256 "eba8cbc4bfac785bb64bae88bcdbaaf583127d5ee33e7b60e73bd17382b89b8b"
    end
    on_intel do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.10.0/sazare-server-macos-amd64.tar.gz"
      sha256 "4e917e03f04366548b122aaf2d90e96e2cb7d4d9e23b1e7d29f0a3e512acce60"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.10.0/sazare-server-linux-arm64.tar.gz"
      sha256 "7f7565d050c27fd0943809dca4529f020a7171f5fd47386ac453e0ac600387db"
    end
    on_intel do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.10.0/sazare-server-linux-amd64.tar.gz"
      sha256 "4a39ea308a114795be8ea76ebff4548247d3d9aba726295aef47e808ea5c57a4"
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
