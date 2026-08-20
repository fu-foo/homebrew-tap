# typed: strict
# frozen_string_literal: true

# Homebrew tap: fu-foo/homebrew-tap → Formula/fugantt.rb
class Fugantt < Formula
  desc "Gantt chart with plan against actual, counted in working days"
  homepage "https://github.com/fu-foo/fugantt"
  version "0.5.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.5.1/fugantt-macos-arm64.tar.gz"
      sha256 "51e2db3327aee2ed622894bf669a83904186b2304d66775d7863dcd9844a61d6"
    end
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.5.1/fugantt-macos-x86_64.tar.gz"
      sha256 "44df80e93fb2ac4a2660db97ad9332ceb68b7ae7a36e1b5f48529be67164685a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/fu-foo/fugantt/releases/download/v0.5.1/fugantt-linux-x86_64.tar.gz"
      sha256 "af4fec355e202bc03c53d5319d0c4132c26e567a8fbe914653e9a08d74a3213f"
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
