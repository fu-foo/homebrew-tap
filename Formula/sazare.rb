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
  version "0.15.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.15.1/sazare-server-macos-arm64.tar.gz"
      sha256 "480fcc9ef6698114f151f10904dbc0fef1286b9dbabf58623cc9ac676b92486a"
    end
    on_intel do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.15.1/sazare-server-macos-amd64.tar.gz"
      sha256 "0ceaf9cf427b1dbf2f952edbf5b95cb41b5ef9252bf329bde512dad596654d24"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.15.1/sazare-server-linux-arm64.tar.gz"
      sha256 "fb73fe3dcffac162752bae702582202cbf6bbfe588226238e5256e5336234309"
    end
    on_intel do
      url "https://github.com/fu-foo/fhir-sazare/releases/download/v0.15.1/sazare-server-linux-amd64.tar.gz"
      sha256 "13a56eb36019103858142a57acc36556352bd4d46c98d13970e83f5d52286ad5"
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
