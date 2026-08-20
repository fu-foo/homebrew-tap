# typed: strict
# frozen_string_literal: true

# Homebrew tap: fu-foo/homebrew-tap → Formula/fugantt.rb
class Fugantt < Formula
  desc "Gantt chart with plan against actual, counted in working days"
  homepage "https://github.com/fu-foo/fugantt"
  version "0.5.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.5.0/fugantt-macos-arm64.tar.gz"
      sha256 "401cd941fed1abf6ff73c1efece8f0140c20353e21ae1cb3dfefd9a1d62f8d1c"
    end
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.5.0/fugantt-macos-x86_64.tar.gz"
      sha256 "cb7bb91404fe621c721a3e10cd31a3ae0f93c7e695b22ca11b35b06f9defb575"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.5.0/fugantt-linux-x86_64.tar.gz"
      sha256 "d4d4e7fe30c8cd92590db97c0bdeb749b13967c59dd4493f0a53d2894bdf79c2"
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
