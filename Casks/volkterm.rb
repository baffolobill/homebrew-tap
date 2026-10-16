# Source-of-truth Homebrew cask for volkterm. scripts/release.sh copies it into
# baffolobill/homebrew-tap (Casks/volkterm.rb) on every publish and sets version + sha256.
cask "volkterm" do
  version "1.5.16"
  sha256 "3cf7761e6f9e44f253fa1491aedf94f263c5687b41ab96f43663f7566f1838cc"

  url "https://github.com/baffolobill/volkterm/releases/download/v#{version}/volkterm-#{version}.dmg"
  name "volkterm"
  desc "Tiled terminal on libghostty for running many coding agents at once"
  homepage "https://github.com/baffolobill/volkterm"

  depends_on macos: :sonoma

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
