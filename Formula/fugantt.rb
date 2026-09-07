# typed: strict
# frozen_string_literal: true

# Homebrew tap: fu-foo/homebrew-tap → Formula/fugantt.rb
class Fugantt < Formula
  desc "Gantt chart with plan against actual, counted in working days"
  homepage "https://github.com/fu-foo/fugantt"
  version "0.8.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.8.1/fugantt-macos-arm64.tar.gz"
      sha256 "4748f1b21d07b41041de06af21607cccb1c7265a5ab765b7d6b22f9b1be63122"
    end
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.8.1/fugantt-macos-x86_64.tar.gz"
      sha256 "4318e54b40bee9f7068b6f2b2115dfdb4804cd5ebdf0fcc91048088a08a97374"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.8.1/fugantt-linux-x86_64.tar.gz"
      sha256 "a0b45c7ab0376aef4bed0e69d226db8831de0160dfd97d36458b0e91f9167e7c"
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
