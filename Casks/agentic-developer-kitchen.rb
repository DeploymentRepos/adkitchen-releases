cask "agentic-developer-kitchen" do
  version "0.4.0"
  sha256 "60d4da54ee45747ddbbf278f31541f262b0963b6ff69efffaf06113b7dbddd44"

  url "https://github.com/DeploymentRepos/adkitchen-releases/releases/download/v#{version}/Agentic-Developer-Kitchen-#{version}.pkg"
  name "Agentic Developer Kitchen"
  desc "Agentic development environment for macOS"
  homepage "https://agenticdeveloperkitchen.com/"

  livecheck do
    url "https://agenticdeveloperkitchen.com/appcast.xml"
    strategy :sparkle
  end

  auto_updates true
  depends_on macos: :tahoe

  pkg "Agentic-Developer-Kitchen-#{version}.pkg"

  # The app embeds its session daemon, adkd (Contents/MacOS/adkd), registered as
  # the LaunchAgent com.agenticdevelopmentstudio.adkd, with `# adkd-hook` Claude
  # Code hooks and a status-line tap pointing into the bundle. brew runs
  # launchctl, quit, script, pkgutil, delete in that order, so the job is booted
  # out first and `adkd --uninstall-hooks` runs with the daemon stopped and the
  # binary still on disk (as Stenographer's cask does for stenographerd).
  uninstall launchctl: "com.agenticdevelopmentstudio.adkd",
            quit:      "com.agenticdevelopmentstudio.agenticdeveloperkitchen",
            script:    {
              executable: "/Applications/Agentic Developer Kitchen.app/Contents/MacOS/adkd",
              args:       ["--uninstall-hooks"],
            },
            pkgutil:   "com.agenticdevelopmentstudio.agenticdeveloperkitchen",
            delete:    [
              "~/.claude/adkd.sock",
              "~/Library/LaunchAgents/com.agenticdevelopmentstudio.adkd.plist",
            ]

  # The app keeps its data in ~/.<name, letters and digits, lowercased>
  # (AppStorageLocation), adkd's database included (~/.agenticdeveloperkitchen/adkd),
  # so only a zap removes it. The hook drop directory is here, not in `delete:`,
  # because brew runs `delete:` on every reinstall and upgrade too, and it may
  # hold events adkd has not ingested yet (Stenographer zaps its own likewise).
  zap trash: [
    "~/.agenticdeveloperkitchen",
    "~/.claude/adkd-events",
    "~/Library/Logs/com.agenticdevelopmentstudio.adkd",
    "~/Library/Preferences/com.agenticdevelopmentstudio.agenticdeveloperkitchen.plist",
  ]

  caveats <<~EOS
    Agentic Developer Kitchen updates itself with Sparkle. Update it from the app, or with:
      brew upgrade --cask agentic-developer-kitchen
  EOS
end
