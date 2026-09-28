# Source-of-truth Homebrew cask for volkterm. scripts/release.sh seeds this into
# baffolobill/homebrew-tap (Casks/volkterm.rb) on first publish and rewrites the
# version + sha256 lines on every release.
cask "volkterm" do
  version "1.4.2"
  sha256 "762139ca5abe3459dfa8b180b4b3a7a105a7a5756e6fe86a6b3f097f1e4b474d"

  url "https://github.com/baffolobill/volkterm/releases/download/v#{version}/volkterm-#{version}.dmg"
  name "volkterm"
  desc "Tiled terminal on libghostty for running many coding agents at once"
  homepage "https://github.com/baffolobill/volkterm"

  depends_on macos: :sonoma
  depends_on arch: :arm64

  app "volkterm.app"
  binary "#{appdir}/volkterm.app/Contents/MacOS/volktermctl", target: "volktermctl"

  # strip Homebrew's com.apple.quarantine: the fork's releases are not notarized, so
  # Gatekeeper would refuse to open a quarantined bundle, and brew re-stamps the
  # attribute on every fresh install and upgrade.
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/volkterm.app"]
  end

  zap trash: [
    "~/Library/Application Support/volkterm",
    "~/Library/Preferences/com.volkoffhq.volkterm.plist",
    "~/Library/Saved Application State/com.volkoffhq.volkterm.savedState",
  ]
end
