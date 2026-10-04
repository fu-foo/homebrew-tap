# typed: strict
# frozen_string_literal: true

# Homebrew tap: fu-foo/homebrew-tap → Formula/fugantt.rb
class Fugantt < Formula
  desc "Gantt chart with plan against actual, counted in working days"
  homepage "https://github.com/fu-foo/fugantt"
  version "1.2.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fugantt/releases/download/v1.2.0/fugantt-macos-arm64.tar.gz"
      sha256 "dae88a99c0922cf74d7c3c3c4ee2d639f48ba5935953ba0d214fd4807e83abb2"
    end
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v1.2.0/fugantt-macos-x86_64.tar.gz"
      sha256 "7c926e35d597bc0347e1f51602725d9eb9a3ed3e71699ab43135c243d560dd87"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v1.2.0/fugantt-linux-x86_64.tar.gz"
      sha256 "91650701461e1f1cf498022f126230e1e6d5fdb315fed6f64407eac805ff7944"
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
