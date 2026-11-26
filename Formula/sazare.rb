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
  version "0.15.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.15.0/sazare-server-macos-arm64.tar.gz"
      sha256 "2e020fd2dbc60bc68a8fb74b0be783a2a6b1ec669334347f43ffadb7faaacc68"
    end
    on_intel do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.15.0/sazare-server-macos-amd64.tar.gz"
      sha256 "c27e473d8d190aeea071e7f6328ad53bb47ef164ea74917de5730624f3a64838"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.15.0/sazare-server-linux-arm64.tar.gz"
      sha256 "1be50fe9afbb2b9a6bcddc63cc7efc3a4d2ab8174a76ddfb35da511bb4dc25b0"
    end
    on_intel do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.15.0/sazare-server-linux-amd64.tar.gz"
      sha256 "b8116bd69dab24f9562cd2a017a3002aa72ed281ec86655e706c543aa857b410"
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
