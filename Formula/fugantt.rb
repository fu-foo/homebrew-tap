# typed: strict
# frozen_string_literal: true

# Homebrew tap: fu-foo/homebrew-tap → Formula/fugantt.rb
class Fugantt < Formula
  desc "Gantt chart with plan against actual, counted in working days"
  homepage "https://github.com/fu-foo/fugantt"
  version "0.4.6"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.4.6/fugantt-macos-arm64.tar.gz"
      sha256 "9dba8a65bdcd79ab35d1ea5c31493f9bbe5e4e21400ae65abef4b5898ad0a67a"
    end
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.4.6/fugantt-macos-x86_64.tar.gz"
      sha256 "8716caaea4b7fd63f89ecd0f38445d56ba2d7a2dac59fc3ed5c63b9f2ed48155"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.4.6/fugantt-linux-x86_64.tar.gz"
      sha256 "0cb69c56322731fed5c3a65709a29daaf914af2f9b84190f9111bbfbbcf06b04"
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
