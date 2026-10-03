# Source-of-truth Homebrew cask for volkterm. scripts/release.sh copies it into
# baffolobill/homebrew-tap (Casks/volkterm.rb) on every publish and sets version + sha256.
cask "volkterm" do
  version "1.5.9"
  sha256 "6d0a54113b715aa0604fca2c641e33272b72f0963e63f08ac46ce545ca935f28"

  url "https://github.com/baffolobill/volkterm-releases/releases/download/v#{version}/volkterm-#{version}.dmg"
  name "volkterm"
  desc "Tiled terminal on libghostty for running many coding agents at once"
  homepage "https://github.com/baffolobill/volkterm-releases"

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
