# typed: strict
# frozen_string_literal: true

# Homebrew tap: fu-foo/homebrew-tap → Formula/fugantt.rb
class Fugantt < Formula
  desc "Gantt chart with plan against actual, counted in working days"
  homepage "https://github.com/fu-foo/fugantt"
  version "0.8.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.8.2/fugantt-macos-arm64.tar.gz"
      sha256 "bcd3d36e1c9c427481dcfa9c0d29063a18abc8dd0faee584e9daa5f78e5c771d"
    end
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.8.2/fugantt-macos-x86_64.tar.gz"
      sha256 "1eb05e68931ec2455a533f226b34ee4c68929f03cdaed2f9053a053be12be728"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.8.2/fugantt-linux-x86_64.tar.gz"
      sha256 "e17798c4ea09a64b137a2f046986d3136330e0600efdf418c03814bd9f6c72e7"
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
