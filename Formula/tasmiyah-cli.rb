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
  version "0.2.0"
  license "MIT"

  on_macos do
    # Only Apple Silicon is shipped as a prebuilt binary. Intel Mac users
    # should install via `cargo install tasmiyah-cli` instead — the ARM
    # binary does not run on Intel under Rosetta 2.
    on_arm do
      url "https://github.com/bhantsi/tasmiyah-cli/releases/download/v#{version}/tasmiyah-aarch64-apple-darwin.tar.gz"
      sha256 "6ca9e708861af6223f39bc54568d92b2c3c71f7063bc35a472c2f4714da7a9c0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bhantsi/tasmiyah-cli/releases/download/v#{version}/tasmiyah-aarch64-unknown-linux-musl.tar.gz"
      sha256 "14d747b714a97128ea8211349f0ab64d9e3b62b324b70469cb55af0dd6af3db5"
    end
    on_intel do
      url "https://github.com/bhantsi/tasmiyah-cli/releases/download/v#{version}/tasmiyah-x86_64-unknown-linux-musl.tar.gz"
      sha256 "8628dc2fbf6952518c6eca2b9638173dcde59a4826498c0a8ab4d6a210c770cd"
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
