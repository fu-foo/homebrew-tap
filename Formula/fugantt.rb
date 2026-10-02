# typed: strict
# frozen_string_literal: true

# Homebrew tap: fu-foo/homebrew-tap → Formula/fugantt.rb
class Fugantt < Formula
  desc "Gantt chart with plan against actual, counted in working days"
  homepage "https://github.com/fu-foo/fugantt"
  version "1.0.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fugantt/releases/download/v1.0.0/fugantt-macos-arm64.tar.gz"
      sha256 "5bed94f6249b2a8d29ed73002cc2d3df059f711ccdd703cb80a0c8a93bfe28a8"
    end
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v1.0.0/fugantt-macos-x86_64.tar.gz"
      sha256 "cb2b01b0404ff91a002f8b7110d6afc73965e4e558285bd0a2dcf22421c1b3fe"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v1.0.0/fugantt-linux-x86_64.tar.gz"
      sha256 "cb30948550ba111ab52620589cf3883ec38c0d388153ca220aaef8e5649c89cf"
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
