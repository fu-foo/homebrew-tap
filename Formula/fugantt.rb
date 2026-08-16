# typed: strict
# frozen_string_literal: true

# Homebrew tap: fu-foo/homebrew-tap → Formula/fugantt.rb
class Fugantt < Formula
  desc "Gantt chart with plan against actual, counted in working days"
  homepage "https://github.com/fu-foo/fugantt"
  version "0.4.5"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.4.5/fugantt-macos-arm64.tar.gz"
      sha256 "10a0087a36a5703fe7edfc4435ceb4dab3c4d94d29d08d143893680426118904"
    end
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.4.5/fugantt-macos-x86_64.tar.gz"
      sha256 "765a872ab78ab83cdaae6458ccfcfb647d58aad59c1386e19a03ef685f34bced"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.4.5/fugantt-linux-x86_64.tar.gz"
      sha256 "99af1f47c4629fb832f1fb8e7059b140790495d1ad2451047dccbe9cc3f5ddd0"
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
