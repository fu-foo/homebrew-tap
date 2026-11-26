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
  version "0.16.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.16.0/sazare-server-macos-arm64.tar.gz"
      sha256 "7632f5141435367e2ff08972735cb0b2a2cb28e2644f02b6078787fd0d44d127"
    end
    on_intel do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.16.0/sazare-server-macos-amd64.tar.gz"
      sha256 "24e1eaae8421f6d38a0c0fc80063623c4f1c700526a6a6fa761f9641f933adc7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.16.0/sazare-server-linux-arm64.tar.gz"
      sha256 "67c7aab4717e0c7b3948c81ba66fdf1ebb3b73d73e79d2482fe483b7fa115c1e"
    end
    on_intel do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.16.0/sazare-server-linux-amd64.tar.gz"
      sha256 "a0fb6efe9948de6770dee5ab03936cfa695dee741f134b9f42a52e833b0f8db5"
    end
  end

  def install
    bin.install "sazare-server"
  end

  # `brew services start sazare`: runs the server in the foreground under
  # launchd / systemd. Without a configuration file it uses the user's data
  # directory; ~/.config/sazare/config.yaml (or the platform equivalent) is
  # picked up when present.
  service do
    run [opt_bin/"sazare-server", "run"]
    keep_alive true
    working_dir var/"sazare"
    log_path var/"log/sazare.log"
    error_log_path var/"log/sazare.log"
  end

  def post_install
    (var/"sazare").mkpath
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sazare-server version")
    port = free_port
    pid = fork do
      ENV["SAZARE_PORT"] = port.to_s
      ENV["SAZARE_DATA_DIR"] = testpath/"data"
      exec bin/"sazare-server", "run"
    end
    sleep 5
    assert_match(/"status":"ok"/, shell_output("curl -fsS http://127.0.0.1:#{port}/health"))
  ensure
    Process.kill("TERM", pid) if pid
  end
end
