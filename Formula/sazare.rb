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
  version "0.14.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.14.0/sazare-server-macos-arm64.tar.gz"
      sha256 "782241a900802b2384547e861380bda8497abbbbba6b7b7c1ffc6ae83359f91f"
    end
    on_intel do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.14.0/sazare-server-macos-amd64.tar.gz"
      sha256 "664325931cf93c265a156c5bea27c8520e550e74456175fa96aa6d42e617ae35"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.14.0/sazare-server-linux-arm64.tar.gz"
      sha256 "4c3ff2d86653af299d5b9ae5c57946ff834999671938e17587461e5fbfa5cd8a"
    end
    on_intel do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.14.0/sazare-server-linux-amd64.tar.gz"
      sha256 "098081e111522b8da942234c5e86e1ea3d0c49e2058bc7738c02d48f5a653208"
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
