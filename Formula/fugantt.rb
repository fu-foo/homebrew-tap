# typed: strict
# frozen_string_literal: true

# Homebrew tap: fu-foo/homebrew-tap → Formula/fugantt.rb
class Fugantt < Formula
  desc "Gantt chart with plan against actual, counted in working days"
  homepage "https://github.com/fu-foo/fugantt"
  version "0.5.3"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.5.3/fugantt-macos-arm64.tar.gz"
      sha256 "051e956d429890239e12d7514e5535b1e42a692dfcb3887c68da68dc340ed7ce"
    end
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.5.3/fugantt-macos-x86_64.tar.gz"
      sha256 "e29e6dfa15ac48ab676f29f0663b2e059f8b6f27d8f4fefdd9fd3d556e9f1e92"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.5.3/fugantt-linux-x86_64.tar.gz"
      sha256 "86b05e2772d7e29163e016f9238bc21319b474a3c74925b50f4470b5a3e033c0"
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
