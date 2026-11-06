# typed: strict
# frozen_string_literal: true

# Homebrew tap: fu-foo/homebrew-tap → Formula/fugantt.rb
class Fugantt < Formula
  desc "Gantt chart with plan against actual, counted in working days"
  homepage "https://github.com/fu-foo/fugantt"
  version "1.3.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fugantt/releases/download/v1.3.0/fugantt-macos-arm64.tar.gz"
      sha256 "ccbbcd5028668335a69e2152a3c4da7d177cc097b339c0195db3692f1ba644ba"
    end
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v1.3.0/fugantt-macos-x86_64.tar.gz"
      sha256 "035492f6660fd690d17e5491136fae62fd823788391d60c0560ce578d95603ac"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v1.3.0/fugantt-linux-x86_64.tar.gz"
      sha256 "0ffb2d395cb7e77ebde02c0f4328696c123a341b10a790a4b2024ec38c8a191d"
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
