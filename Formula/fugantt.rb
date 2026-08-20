# typed: strict
# frozen_string_literal: true

# Homebrew tap: fu-foo/homebrew-tap → Formula/fugantt.rb
class Fugantt < Formula
  desc "Gantt chart with plan against actual, counted in working days"
  homepage "https://github.com/fu-foo/fugantt"
  version "0.7.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.7.1/fugantt-macos-arm64.tar.gz"
      sha256 "b2dfc81624ff2ab5abfe06ce92c4afea10124ffd35b0fd684b01f6eb7f696fb7"
    end
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.7.1/fugantt-macos-x86_64.tar.gz"
      sha256 "c19746a33b51ebd9aa20e1a7da01b06c7dc919b28026fd8a4e22bcd3b00b399d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.7.1/fugantt-linux-x86_64.tar.gz"
      sha256 "f44898e7c1097e0027ab2ab998ae11ce61b3410c95fb953ecfa09a7a55b11ffc"
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
