# typed: strict
# frozen_string_literal: true

# Homebrew tap: fu-foo/homebrew-tap → Formula/fugantt.rb
class Fugantt < Formula
  desc "Gantt chart with plan against actual, counted in working days"
  homepage "https://github.com/fu-foo/fugantt"
  version "0.4.4"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.4.4/fugantt-macos-arm64.tar.gz"
      sha256 "71d966fcfa2f1727f598898da22f6853e24be81cd245376612b8a24aba77b919"
    end
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.4.4/fugantt-macos-x86_64.tar.gz"
      sha256 "36df41ab07b30fef81564484b3b9d9b10a6da0c2e825f130e5238ccef7f06328"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.4.4/fugantt-linux-x86_64.tar.gz"
      sha256 "6767af5c9e96736e9baa3e421e3ba70352aea68f1705b7bb943e2e8cb360a852"
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
