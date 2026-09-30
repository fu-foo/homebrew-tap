# typed: strict
# frozen_string_literal: true

# Homebrew tap: fu-foo/homebrew-tap → Formula/fugantt.rb
class Fugantt < Formula
  desc "Gantt chart with plan against actual, counted in working days"
  homepage "https://github.com/fu-foo/fugantt"
  version "0.8.3"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.8.3/fugantt-macos-arm64.tar.gz"
      sha256 "b51c86d5719c8faaae0f3499d24f81a6f5ae8d728c6d29307222b10df69c5e5e"
    end
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.8.3/fugantt-macos-x86_64.tar.gz"
      sha256 "64a0757f8c94fcdc5b6ff63680860bee9dc25938ff461a5b434e44a75f9b6752"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.8.3/fugantt-linux-x86_64.tar.gz"
      sha256 "c9a2de93a731f7a80e6edb3a6a20621b6f5ee6ffd91fd589f8995489082e21c4"
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
