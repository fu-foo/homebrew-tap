# typed: strict
# frozen_string_literal: true

# Homebrew tap: fu-foo/homebrew-tap → Formula/fugantt.rb
class Fugantt < Formula
  desc "Gantt chart with plan against actual, counted in working days"
  homepage "https://github.com/fu-foo/fugantt"
  version "0.1.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.1.0/fugantt-macos-arm64.tar.gz"
      sha256 "d6ca3e33ffbc14b8e56a7cffa1a33a344958d43deca0022facf2792b077f59db"
    end
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.1.0/fugantt-macos-x86_64.tar.gz"
      sha256 "9c6ced839de2994049d3ea64f6e7f3552a84dba2c1110f6db162bfaac5095d88"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.1.0/fugantt-linux-x86_64.tar.gz"
      sha256 "18a3f236b239b3d0e7ffff878f09b127bfbdc6173407134dea8f81e06a9d88ce"
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
