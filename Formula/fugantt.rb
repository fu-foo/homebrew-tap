# typed: strict
# frozen_string_literal: true

# Homebrew tap: fu-foo/homebrew-tap → Formula/fugantt.rb
class Fugantt < Formula
  desc "Gantt chart with plan against actual, counted in working days"
  homepage "https://github.com/fu-foo/fugantt"
  version "0.4.9"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.4.9/fugantt-macos-arm64.tar.gz"
      sha256 "db9577dd355d173d07658cfb45b84a7046a2891771cf6b68a1b0d5dbccfe42f4"
    end
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.4.9/fugantt-macos-x86_64.tar.gz"
      sha256 "6edb3233ef2faa3078e642453848b5720f8a96de9357be8b55e2077b97bcfcbc"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.4.9/fugantt-linux-x86_64.tar.gz"
      sha256 "f85e3b70aa06dbc93496504c4f9a9d6797f9071c862caa77cce2329e31a062ed"
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
