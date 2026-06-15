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
  version "0.6.3"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.6.3/sazare-server-macos-arm64.tar.gz"
      sha256 "79e45c70ae98e63cb816f051450b5f6fe7f4feb44958740ccd08c18162df9044"
    end
    on_intel do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.6.3/sazare-server-macos-amd64.tar.gz"
      sha256 "e0c25311dd9bd85c15f22cc3f6d9b6bffffba60c837893a09c6e3ce0307bf1d8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.6.3/sazare-server-linux-arm64.tar.gz"
      sha256 "985d6ee473f0057d56e01b140d505f97e4d18e68d3aa21022365ea927eb8c81b"
    end
    on_intel do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.6.3/sazare-server-linux-amd64.tar.gz"
      sha256 "51e6f6ee4e341677888c8e5411422fa6d6de72a274b8817001006a419827cdfa"
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
