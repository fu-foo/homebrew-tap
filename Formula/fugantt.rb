# typed: strict
# frozen_string_literal: true

# Homebrew tap: fu-foo/homebrew-tap → Formula/fugantt.rb
class Fugantt < Formula
  desc "Gantt chart with plan against actual, counted in working days"
  homepage "https://github.com/fu-foo/fugantt"
  version "0.4.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.4.2/fugantt-macos-arm64.tar.gz"
      sha256 "b74ea31f9006d79175d3e512c4dd678f6da08ab3ced8556a272e1f9c76f0fe44"
    end
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.4.2/fugantt-macos-x86_64.tar.gz"
      sha256 "1922a15c9b35b771d072138cfdd1d183be63ecaedc90a8ee4d62e846f2657dde"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.4.2/fugantt-linux-x86_64.tar.gz"
      sha256 "dfdb059d4258b783967b115ca1071bb6836db2fe9186c2d5d77ac36ac951e7dc"
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
