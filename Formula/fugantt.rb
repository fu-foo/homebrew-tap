# typed: strict
# frozen_string_literal: true

# Homebrew tap: fu-foo/homebrew-tap → Formula/fugantt.rb
class Fugantt < Formula
  desc "Gantt chart with plan against actual, counted in working days"
  homepage "https://github.com/fu-foo/fugantt"
  version "0.7.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.7.2/fugantt-macos-arm64.tar.gz"
      sha256 "3bad4452320c6df0435d9173f248a88add84d56136a746e94640f02f28785674"
    end
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.7.2/fugantt-macos-x86_64.tar.gz"
      sha256 "8baea146b925908ed4d586bf824458e9a71842faedf5af13059701e75bdb97e0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.7.2/fugantt-linux-x86_64.tar.gz"
      sha256 "1c7101250bec9a44ab16ac573e384fcebcd99af6d9b2ffb737102d7fdd40eb79"
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
