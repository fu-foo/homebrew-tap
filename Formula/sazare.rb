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
  version "0.18.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.18.1/sazare-server-macos-arm64.tar.gz"
      sha256 "b05d189ff37b5df8ea282613513ac98f098572bb36528b406015657d7841faf3"
    end
    on_intel do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.18.1/sazare-server-macos-amd64.tar.gz"
      sha256 "c3c7d650519570866629cef555950ba835aab72279eb5cdbf403c80b914e0620"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.18.1/sazare-server-linux-arm64.tar.gz"
      sha256 "ba07d28b8fe88fc8566e962b94f119cae414d56641e3ebf8373cb6de77f50376"
    end
    on_intel do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.18.1/sazare-server-linux-amd64.tar.gz"
      sha256 "c2e66b1d209473eabc1356253085c9cd3b50d16238491119325b1c214a25c143"
    end
  end

  def install
    bin.install "sazare-server"
  end

  # `brew services start sazare`: runs the server in the foreground under
  # launchd / systemd. Without a configuration file it uses the user's data
  # directory; ~/.config/sazare/config.yaml (or the platform equivalent) is
  # picked up when present.
  #
  # The server writes var/log/sazare.log itself and turns it over at 50 MB
  # (sazare.log.1 keeps the one before; SAZARE_LOG_FILE, from 0.17 — older
  # versions log to stdout, which goes to the same file).
  service do
    run [opt_bin/"sazare-server", "run"]
    keep_alive true
    working_dir var/"sazare"
    environment_variables SAZARE_LOG_FILE: (var/"log/sazare.log").to_s
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
