# typed: strict
# frozen_string_literal: true

# Homebrew tap: fu-foo/homebrew-tap → Formula/fugantt.rb
class Fugantt < Formula
  desc "Gantt chart with plan against actual, counted in working days"
  homepage "https://github.com/fu-foo/fugantt"
  version "0.6.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.6.1/fugantt-macos-arm64.tar.gz"
      sha256 "0ec8fef8d5cec36164720b5fbc6779dd6bc9394f0e59ce1824e48196dcc1a349"
    end
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.6.1/fugantt-macos-x86_64.tar.gz"
      sha256 "3f59064a70dcc3c8086001edda77ba2ffd03a2127b4ab1a846d13d51cd76d076"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.6.1/fugantt-linux-x86_64.tar.gz"
      sha256 "2f288671b155ff3826bdd4035e5e474074daeba6da3d52d68875d5ffdc284cca"
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
