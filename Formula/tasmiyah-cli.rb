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
      sha256 "8166411102a87e497704a48aacfebb246ae26473ab1d9e622482b0257948b955"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bhantsi/tasmiyah-cli/releases/download/v#{version}/tasmiyah-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f68820890b1f4424516fac1cb2424a4900c73ec0047f79265c78033764f58cb8"
    end
    on_intel do
      url "https://github.com/bhantsi/tasmiyah-cli/releases/download/v#{version}/tasmiyah-x86_64-unknown-linux-musl.tar.gz"
      sha256 "014a59864f1315041cb1740157055900be60f407da7de7e6339755fe2b002a27"
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
