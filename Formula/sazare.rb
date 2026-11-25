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
  version "0.12.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.12.0/sazare-server-macos-arm64.tar.gz"
      sha256 "745b139297c8a0ae9663f3d229ec098b3112b3bc9994addb3db416a9f17e2ef3"
    end
    on_intel do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.12.0/sazare-server-macos-amd64.tar.gz"
      sha256 "c3d721f709e1838e627c413f40bea15703b7b02fd02349a10c07009754856a6a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.12.0/sazare-server-linux-arm64.tar.gz"
      sha256 "af7afa624d2403ad67066588d60fb5b9aac9a661477b99e87541b492e0946b7c"
    end
    on_intel do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.12.0/sazare-server-linux-amd64.tar.gz"
      sha256 "45ea17ebfbd089b2eed0a44c86cf26f4a3ab0f00b95e88216cf97292a040603a"
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
