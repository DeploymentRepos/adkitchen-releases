cask "agentic-developer-kitchen" do
  version "0.1.0"
  sha256 "76beaa359970dd76afda912eb65e66c0c5bbb5de0650eb342174fb172997ae42"

  url "https://github.com/agenticdevelopmentstudio/agenticdeveloperkitchen-releases/releases/download/v#{version}/Agentic-Developer-Kitchen-#{version}.pkg"
  name "Agentic Developer Kitchen"
  homepage "https://agenticdeveloperkitchen.com/"

  livecheck do
    url "https://agenticdeveloperkitchen.com/appcast.xml"
    strategy :sparkle
  end

  auto_updates true
  depends_on macos: :tahoe

  pkg "Agentic-Developer-Kitchen-#{version}.pkg"

  uninstall delete: "/Applications/Agentic Developer Kitchen.app"

  zap trash: [
    "~/.agenticdeveloperkitchen",
    "~/Library/Preferences/com.agenticdevelopmentstudio.agenticdeveloperkitchen.plist",
  ]
end
