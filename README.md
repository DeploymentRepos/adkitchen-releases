# agenticdeveloperkitchen-releases

Published builds of Agentic Developer Kitchen, a macOS menu bar app for notes,
AI chat, and terminals. This repo holds release output only; the source lives
elsewhere.

`Scripts/release.py` in the Agentic Developer Kitchen repo writes everything
here. Don't edit these files by hand.

| Path | What it is | Who reads it |
|---|---|---|
| GitHub Release `vX.Y.Z` | `Agentic-Developer-Kitchen-X.Y.Z.pkg` (first install) and `Agentic-Developer-Kitchen-X.Y.Z.zip` (Sparkle update) | people installing the app, and Sparkle |
| `releases.json` | release metadata (schema 1), newest first | agenticdeveloperkitchen.com `/downloads` |
| `appcast.xml` | EdDSA-signed Sparkle feed | agenticdeveloperkitchen.com `/appcast.xml`, which installed apps poll |
| `notes/X.Y.Z.md` | release notes | `/downloads` and Sparkle's update dialog |
| `Casks/agentic-developer-kitchen.rb` | Homebrew cask for the latest release | `brew install` |

The website reads these files at request time, so publishing a release never
needs a site deploy. Installed apps poll `https://agenticdeveloperkitchen.com/appcast.xml`,
never this repo directly. That way the storage can move without leaving
installed copies behind.
