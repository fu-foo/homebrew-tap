# typed: strict
# frozen_string_literal: true

# Homebrew tap: fu-foo/homebrew-tap → Formula/fugantt.rb
class Fugantt < Formula
  desc "Gantt chart with plan against actual, counted in working days"
  homepage "https://github.com/fu-foo/fugantt"
  version "0.5.4"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.5.4/fugantt-macos-arm64.tar.gz"
      sha256 "bdd9e0084e34318ef18376e38f1abed89001ad084b3bac85b2ef2afc66a7d46d"
    end
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.5.4/fugantt-macos-x86_64.tar.gz"
      sha256 "47203367fb44744513e163c77ef1da64a37e4d155b63e261134c838d2ea28720"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.5.4/fugantt-linux-x86_64.tar.gz"
      sha256 "39efc7b09036e460a7d92d76ad0a76472f4b36aa5b4e9b2efbff65dce0a986f8"
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
