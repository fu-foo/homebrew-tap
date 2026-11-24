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
  version "0.8.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.8.0/sazare-server-macos-arm64.tar.gz"
      sha256 "29f4717721229cdf1bd823737526d2838da24d7bdc5d6e835c936501f8ff4517"
    end
    on_intel do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.8.0/sazare-server-macos-amd64.tar.gz"
      sha256 "9f9e17293aceaff7776a566466e4ec67792fa2a47a2d14b8acbc040000fa80b9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.8.0/sazare-server-linux-arm64.tar.gz"
      sha256 "41f178892d488cebae9ec3df6420d57357c4e9aa96dd2b2f61b228056d2fbded"
    end
    on_intel do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.8.0/sazare-server-linux-amd64.tar.gz"
      sha256 "37e9799ab47715de5e7ca41baf4fcba02e6cb8047576781aaf09edcd22a68ff3"
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
