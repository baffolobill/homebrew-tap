# Source-of-truth Homebrew cask for volkterm. scripts/release.sh copies it into
# baffolobill/homebrew-tap (Casks/volkterm.rb) on every publish and sets version + sha256.
cask "volkterm" do
  version "1.5.20"
  sha256 "67cfcee8341e2eb98ceb4b23b967f5e7b8d5ee8459ae10fcc33e63cb9243e19a"

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
