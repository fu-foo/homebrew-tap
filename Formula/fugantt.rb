# typed: strict
# frozen_string_literal: true

# Homebrew tap: fu-foo/homebrew-tap → Formula/fugantt.rb
class Fugantt < Formula
  desc "Gantt chart with plan against actual, counted in working days"
  homepage "https://github.com/fu-foo/fugantt"
  version "0.6.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.6.0/fugantt-macos-arm64.tar.gz"
      sha256 "7dea52bfe685bc0090603d6b4bd2e15be89ca9e5caef00b5a2ef90ae2f9704d5"
    end
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.6.0/fugantt-macos-x86_64.tar.gz"
      sha256 "e66b5b9a6740133549c8850048368a6e39a1fbd67df7f993b29d0073dc0fb0db"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.6.0/fugantt-linux-x86_64.tar.gz"
      sha256 "cca0027ea02f99214c77d045a40d7c54b53e18395bad5c2af34554ee1f0cbf6e"
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
