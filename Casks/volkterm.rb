# Source-of-truth Homebrew cask for volkterm. scripts/release.sh copies it into
# baffolobill/homebrew-tap (Casks/volkterm.rb) on every publish and sets version + sha256.
cask "volkterm" do
  version "1.5.18"
  sha256 "1851a1d8963293b434f16f1b7ce284aed7c814b2dfdc7ee1369b28de4d3ff728"

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
