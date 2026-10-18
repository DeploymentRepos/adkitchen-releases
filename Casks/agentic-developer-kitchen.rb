cask "agentic-developer-kitchen" do
  version "0.3.0"
  sha256 "26f0f73caf00e927718ba662f9cb3a824300a7aef1ca0f1d2a361053899faeac"

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

  uninstall quit:    "com.agenticdevelopmentstudio.agenticdeveloperkitchen",
            pkgutil: "com.agenticdevelopmentstudio.agenticdeveloperkitchen"

  # The app keeps its data in ~/.<name, letters and digits, lowercased>
  # (AppStorageLocation) and has no daemon, so this is everything it leaves.
  zap trash: [
    "~/.agenticdeveloperkitchen",
    "~/Library/Preferences/com.agenticdevelopmentstudio.agenticdeveloperkitchen.plist",
  ]

  caveats <<~EOS
    Agentic Developer Kitchen updates itself with Sparkle. Update it from the app, or with:
      brew upgrade --cask agentic-developer-kitchen
  EOS
end
