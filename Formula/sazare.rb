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
  version "0.9.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.9.0/sazare-server-macos-arm64.tar.gz"
      sha256 "e24df9a7c1fb765ab22d5d1760f6996103883a9361072a9adcaf3c2ac4d4cf2e"
    end
    on_intel do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.9.0/sazare-server-macos-amd64.tar.gz"
      sha256 "9e0064a45b55820a2ce17d51227d1448406f2ff6dfe17dc50dfb1110db397a4b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.9.0/sazare-server-linux-arm64.tar.gz"
      sha256 "8b12a1cdbdf2bbd3eb77f96a16800fe6e7689bf9fec4bb18dfdc8214b029133d"
    end
    on_intel do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.9.0/sazare-server-linux-amd64.tar.gz"
      sha256 "13324278fe129a52188f4e178f59cb49dc623200d9cc3bd1cb29dc2177dfc15c"
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
