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
  version "0.6.4"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.6.4/sazare-server-macos-arm64.tar.gz"
      sha256 "4a7259198ae57ee599d660e4580bdffbe5d51bf3c52f8af6c4acc02e039a20da"
    end
    on_intel do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.6.4/sazare-server-macos-amd64.tar.gz"
      sha256 "c4fd591d8d35d4d9618894bd1dbeee98ee54fd9738b06864ea4ca28daf14a0fb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.6.4/sazare-server-linux-arm64.tar.gz"
      sha256 "d48ae7a9acabb6941a00d9ec5e068ae46c3191eace6b8458bfaf949ba476b4c6"
    end
    on_intel do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.6.4/sazare-server-linux-amd64.tar.gz"
      sha256 "c3d6874a4ad09f54ad8ee12950e64394316528b21cf90e6f64ca62b36109bf6c"
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
