# typed: strict
# frozen_string_literal: true

# Homebrew tap: fu-foo/homebrew-tap → Formula/fugantt.rb
class Fugantt < Formula
  desc "Gantt chart with plan against actual, counted in working days"
  homepage "https://github.com/fu-foo/fugantt"
  version "0.4.8"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.4.8/fugantt-macos-arm64.tar.gz"
      sha256 "963766958a8dbf0fd16efedb601f2043f91cbca7c50409659682754746befe85"
    end
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.4.8/fugantt-macos-x86_64.tar.gz"
      sha256 "47b69fca7ac1bd181b42ff6c6ef63cafb7d88616d0226ef2eab8a484af12ceba"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.4.8/fugantt-linux-x86_64.tar.gz"
      sha256 "45e94b7a1db8632d14ee7259e655f4b747c8ac0180a544a4164b0cc193499274"
    end
  end

  def install
    bin.install "fugantt"
    prefix.install "LICENSE", "NOTICE", "README.md", "README.en.md"
  end

  test do
    # The server binds a port and stays up, so the honest smoke test is that the
    # binary runs at all on this machine.
    assert_predicate bin/"fugantt", :executable?
  end
end
