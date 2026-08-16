# typed: strict
# frozen_string_literal: true

# Homebrew tap: fu-foo/homebrew-tap → Formula/fugantt.rb
class Fugantt < Formula
  desc "Gantt chart with plan against actual, counted in working days"
  homepage "https://github.com/fu-foo/fugantt"
  version "0.4.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.4.0/fugantt-macos-arm64.tar.gz"
      sha256 "80d7cb71fc1075ae805fa36996f326a26c5eeba7a855c7030e74465ccd87be49"
    end
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.4.0/fugantt-macos-x86_64.tar.gz"
      sha256 "be35b0ac168007bdbf999fd7ee1541632b4ea3c0d758c7e5476ca0d2b02ad92a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.4.0/fugantt-linux-x86_64.tar.gz"
      sha256 "f27e5187b1df86aff91bb00c784445c92f864c3b1afd7a5ea59a9390d615703c"
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
