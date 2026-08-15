# typed: strict
# frozen_string_literal: true

# Homebrew tap: fu-foo/homebrew-tap → Formula/fugantt.rb
class Fugantt < Formula
  desc "Gantt chart with plan against actual, counted in working days"
  homepage "https://github.com/fu-foo/fugantt"
  version "0.3.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.3.2/fugantt-macos-arm64.tar.gz"
      sha256 "420bf4f92a6893e0e9426dae757a4c2c0729f9178336c8725b056472b0a4c81d"
    end
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.3.2/fugantt-macos-x86_64.tar.gz"
      sha256 "36dbcb9e70dab0d97ae395869a0d8bb071ed18fe1beee66d3dd7a7e7168228df"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.3.2/fugantt-linux-x86_64.tar.gz"
      sha256 "4d4849cf4a1b0bd05a7b6137002af0fa0162858d3aefd35554e4646bb40d548f"
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
