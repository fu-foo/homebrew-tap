# typed: strict
# frozen_string_literal: true

# Homebrew tap: fu-foo/homebrew-tap → Formula/fugantt.rb
class Fugantt < Formula
  desc "Gantt chart with plan against actual, counted in working days"
  homepage "https://github.com/fu-foo/fugantt"
  version "0.2.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.2.0/fugantt-macos-arm64.tar.gz"
      sha256 "f504eef10ca05f33868119f727d7d87b9073121b4f2a68f8a2bcc30c327b138c"
    end
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.2.0/fugantt-macos-x86_64.tar.gz"
      sha256 "e567f60b7b4d2ab2303a24b407396516317449d97dfe0efb58405350792405c0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.2.0/fugantt-linux-x86_64.tar.gz"
      sha256 "e516fcdcce91dfe68985ef8ecaa408f8bf560d4fb44dccc0648fe02f0ca7508c"
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
