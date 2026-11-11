# typed: strict
# frozen_string_literal: true

# Homebrew tap: fu-foo/homebrew-tap → Formula/fugantt.rb
class Fugantt < Formula
  desc "Gantt chart with plan against actual, counted in working days"
  homepage "https://github.com/fu-foo/fugantt"
  version "1.3.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fugantt/releases/download/v1.3.1/fugantt-macos-arm64.tar.gz"
      sha256 "f58784561e2059ea58d9491b00a80dd5f54379e0fc9637daee00c1e79bf66758"
    end
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v1.3.1/fugantt-macos-x86_64.tar.gz"
      sha256 "abe982e2a836467c7f6fd3129b3cd85a9cdc64000283610e9aaa5fdac23f6eba"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v1.3.1/fugantt-linux-x86_64.tar.gz"
      sha256 "980f9589b550f4fa0a99aa6754b15c6e916ea47345c8bc9a933e1490c35f031d"
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
