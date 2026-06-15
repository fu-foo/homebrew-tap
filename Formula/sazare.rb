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
  version "0.6.5"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.6.5/sazare-server-macos-arm64.tar.gz"
      sha256 "3f3cd72297c6db6f428f6200bfd1bed9c92d5374699545ac92de74c1387a327f"
    end
    on_intel do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.6.5/sazare-server-macos-amd64.tar.gz"
      sha256 "1ae112f6c5de09ee4a3328f58449920037590fa5eb20974923cfc339d9b3052c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.6.5/sazare-server-linux-arm64.tar.gz"
      sha256 "b1de41b5eef2412dac4662a0ecd7f9624fdf3fd4f34eec3aa730bd7e87b51d6b"
    end
    on_intel do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.6.5/sazare-server-linux-amd64.tar.gz"
      sha256 "8c8cb502408ec38df7cd9f1c8bbb415d1e52bad373488149869e2c286b569cbd"
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
