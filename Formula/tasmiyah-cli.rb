# typed: false
# frozen_string_literal: true

# Homebrew formula template for tasmiyah-cli.
#
# This file is rendered by `.github/workflows/release.yml` (the
# `bump-homebrew` job) on every tag push. `{{VAR}}` placeholders are
# substituted with concrete values and the result is committed to
# bhantsi/homebrew-tap as `Formula/tasmiyah-cli.rb`.
#
# Users then run:
#     brew install bhantsi/tap/tasmiyah-cli
#
# Do NOT rename or remove placeholders without also updating the
# corresponding `sed` invocation in the release workflow.

class TasmiyahCli < Formula
  desc "A beautiful, fast terminal greeting that prints Bismillah and Islamic phrases"
  homepage "https://github.com/bhantsi/tasmiyah-cli"
  version "0.3.0"
  license "MIT"

  on_macos do
    # Only Apple Silicon is shipped as a prebuilt binary. Intel Mac users
    # should install via `cargo install tasmiyah-cli` instead — the ARM
    # binary does not run on Intel under Rosetta 2.
    on_arm do
      url "https://github.com/bhantsi/tasmiyah-cli/releases/download/v#{version}/tasmiyah-aarch64-apple-darwin.tar.gz"
      sha256 "53360941fce2113b3a7b6668c2c2323d8f4b0f09e9c8cb21fbbc3cae7810159b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bhantsi/tasmiyah-cli/releases/download/v#{version}/tasmiyah-aarch64-unknown-linux-musl.tar.gz"
      sha256 "75718eb86bf98b4985c495b9bb539f78cd95204e7d1977840ef1b88531173c03"
    end
    on_intel do
      url "https://github.com/bhantsi/tasmiyah-cli/releases/download/v#{version}/tasmiyah-x86_64-unknown-linux-musl.tar.gz"
      sha256 "aaa9f9b8f9511d3704d5b4e2ddfd9e5b24374bd84057a70e6169dc5eab8de615"
    end
  end

  def install
    bin.install "tasmiyah"
  end

  test do
    # The binary must run and report its own version.
    assert_match version.to_s, shell_output("#{bin}/tasmiyah --version")
    # And it must produce the Basmala in --no-color mode.
    assert_match "Bismill", shell_output("#{bin}/tasmiyah --no-color --translation")
  end
end
