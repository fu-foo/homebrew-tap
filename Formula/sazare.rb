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
  version "0.7.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.7.0/sazare-server-macos-arm64.tar.gz"
      sha256 "c81d15ebe469631457050e00ccad89c7108bd5014851e18de3b07a13f1e9092e"
    end
    on_intel do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.7.0/sazare-server-macos-amd64.tar.gz"
      sha256 "6ddae8fe1ba3eccad73a103424b89e46bbc12bf26e875b11b1a0fa4c7350ad82"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.7.0/sazare-server-linux-arm64.tar.gz"
      sha256 "f74e202e9ca414ecb86235e3f9de1bea3750c138330a2e9de7e33676f119ec00"
    end
    on_intel do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.7.0/sazare-server-linux-amd64.tar.gz"
      sha256 "418c4d6e0c9d2aef39cc7c021468db34802bd7e454bc6bc3eb09e329516d19f5"
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
