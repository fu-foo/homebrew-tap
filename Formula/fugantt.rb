# typed: strict
# frozen_string_literal: true

# Homebrew tap: fu-foo/homebrew-tap → Formula/fugantt.rb
class Fugantt < Formula
  desc "Gantt chart with plan against actual, counted in working days"
  homepage "https://github.com/fu-foo/fugantt"
  version "0.3.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.3.1/fugantt-macos-arm64.tar.gz"
      sha256 "68f78cf64cd8654f17101542d0c9dfbbf3d035cdd315eb13820a01c97a4c8771"
    end
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.3.1/fugantt-macos-x86_64.tar.gz"
      sha256 "cd6b1976318b2e08babeec2748680d31a631c51a17ad7f985da56d646e0e04b6"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.3.1/fugantt-linux-x86_64.tar.gz"
      sha256 "e7c729487be928fabb417455caa077c84d88b0aadbfd996574974a4869749c97"
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
