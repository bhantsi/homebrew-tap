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
  version "0.3.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/bhantsi/tasmiyah-cli/releases/download/v#{version}/tasmiyah-aarch64-apple-darwin.tar.gz"
      sha256 "fd78f9a1e66d12a230e66403a3beed10c4c7844d5a166bf1ac52a1f06d36459a"
    end
    on_intel do
      url "https://github.com/bhantsi/tasmiyah-cli/releases/download/v#{version}/tasmiyah-x86_64-apple-darwin.tar.gz"
      sha256 "060d152c31fc9ddd247c14797d24b47f987cbba3e1a014e2424e0f621c1c11e4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bhantsi/tasmiyah-cli/releases/download/v#{version}/tasmiyah-aarch64-unknown-linux-musl.tar.gz"
      sha256 "9e77f537e1e3fdfc089cd6c349cb7c0a796f2988b10d4e4e1b14c7fcd1857a93"
    end
    on_intel do
      url "https://github.com/bhantsi/tasmiyah-cli/releases/download/v#{version}/tasmiyah-x86_64-unknown-linux-musl.tar.gz"
      sha256 "8dcb75918f664e3aa0a37f93d5f4aa0e3bae5779a3143ce38d9219cd74f8fcbd"
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
