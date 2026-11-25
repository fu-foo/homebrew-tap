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
  version "0.13.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.13.0/sazare-server-macos-arm64.tar.gz"
      sha256 "9ef32436ae7fcf834ce3740516defd0026eee7ed2da75509d23afff7a8c01907"
    end
    on_intel do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.13.0/sazare-server-macos-amd64.tar.gz"
      sha256 "ee7e167028e79d2713f60b619547205fefcfe6db268bc6dc0a89a71c17ab9721"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.13.0/sazare-server-linux-arm64.tar.gz"
      sha256 "6341e0c058ae4734b290dcdab400e0db2731e6e902c224695056d65cf8023ff4"
    end
    on_intel do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.13.0/sazare-server-linux-amd64.tar.gz"
      sha256 "e419ed2eaa0f44a132a440ede77712b46cf40353b7870a018db407533f5118d5"
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
