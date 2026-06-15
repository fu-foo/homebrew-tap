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
  version "0.6.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.6.0/sazare-server-macos-arm64.tar.gz"
      sha256 "e1824a52df73ec4c71f1c0e7585c18e1eb65a9988e232e85ece5b40365904983"
    end
    on_intel do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.6.0/sazare-server-macos-amd64.tar.gz"
      sha256 "a3aa8953b4afb915e0bb0bf7c8b3c24fb0ebda78fe73d95a5c85ac6bc0ba8776"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.6.0/sazare-server-linux-arm64.tar.gz"
      sha256 "4f80cd5ee6dc17e093d6122cb03ffac88baabe9787e92ed78e374694f59d82a0"
    end
    on_intel do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.6.0/sazare-server-linux-amd64.tar.gz"
      sha256 "05e8cac6fbebb8cf659d43354fab9e10b638be3966168f481ad890cf4def16bd"
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
