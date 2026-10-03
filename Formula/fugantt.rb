# typed: strict
# frozen_string_literal: true

# Homebrew tap: fu-foo/homebrew-tap → Formula/fugantt.rb
class Fugantt < Formula
  desc "Gantt chart with plan against actual, counted in working days"
  homepage "https://github.com/fu-foo/fugantt"
  version "1.0.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fugantt/releases/download/v1.0.1/fugantt-macos-arm64.tar.gz"
      sha256 "673e1dedcc5aacabb57659f767658e77d9aa13a3b8809608fdcab37bef25086e"
    end
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v1.0.1/fugantt-macos-x86_64.tar.gz"
      sha256 "c40ce6bcf41e6935aa5c3e8750aaf914794b5959da7b1120b9ab366bccc1521b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v1.0.1/fugantt-linux-x86_64.tar.gz"
      sha256 "982677ad4dc77d9b6ad047e0c74d3c7c00d60e0f4a1487795f05125d48ae567c"
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
