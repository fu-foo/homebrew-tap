# typed: strict
# frozen_string_literal: true

# Homebrew tap: fu-foo/homebrew-tap → Formula/fugantt.rb
class Fugantt < Formula
  desc "Gantt chart with plan against actual, counted in working days"
  homepage "https://github.com/fu-foo/fugantt"
  version "0.4.3"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.4.3/fugantt-macos-arm64.tar.gz"
      sha256 "4b9412466e2bf393c3baf30ddaec52be22dc2503087e47889fd437672c96839a"
    end
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.4.3/fugantt-macos-x86_64.tar.gz"
      sha256 "62acdcca1eeb8f2058a848fcc612df1714f70e7a13381b69b3bbd18bd1b27bda"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.4.3/fugantt-linux-x86_64.tar.gz"
      sha256 "44df50d4a6f3be6b2d917a441a60dab701fb0a89b245a89be24fad12c6dacbf1"
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
