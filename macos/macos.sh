#!/usr/bin/env bash
# macOS system preferences
# Run once after a clean setup. Requires logout/reboot to take full effect.
# Usage: bash ~/.dotfiles/macos/macos.sh

set -euo pipefail

echo "Applying macOS preferences..."

# ── Close System Preferences to prevent conflicts ─────────────────────────────
osascript -e 'tell application "System Preferences" to quit' 2>/dev/null || true

# ── General ───────────────────────────────────────────────────────────────────
# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Disable the "Are you sure you want to open this application?" dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# ── Keyboard ──────────────────────────────────────────────────────────────────
# Fast key repeat (values: 15=225ms, 6=90ms, 2=30ms)
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Disable auto-correct / autocapitalise / smart quotes (annoying in terminals)
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# ── Trackpad ──────────────────────────────────────────────────────────────────
# Tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# ── Dock ──────────────────────────────────────────────────────────────────────
# Auto-hide the dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0.1
defaults write com.apple.dock autohide-time-modifier -float 0.3

# Icon size (pixels)
defaults write com.apple.dock tilesize -int 48

# Don't show recent apps in Dock
defaults write com.apple.dock show-recents -bool false

# Minimize windows into application icon
defaults write com.apple.dock minimize-to-application -bool true

# ── Finder ────────────────────────────────────────────────────────────────────
# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show status bar and path bar
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Default to list view (options: Nlsv=list, icnv=icon, clmv=column, glyv=gallery)
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Disable .DS_Store on network/USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Show ~/Library in Finder
chflags nohidden ~/Library

# ── Screenshots ───────────────────────────────────────────────────────────────
# Save screenshots to ~/Desktop/Screenshots
mkdir -p ~/Desktop/Screenshots
defaults write com.apple.screencapture location -string "~/Desktop/Screenshots"

# Save as PNG (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Disable screenshot thumbnail preview
defaults write com.apple.screencapture show-thumbnail -bool false

# ── Menu Bar ──────────────────────────────────────────────────────────────────
# Show battery percentage
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# 24-hour clock
defaults write NSGlobalDomain AppleICUForce24HourTime -bool true

# ── Activity Monitor ──────────────────────────────────────────────────────────
# Show all processes
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# ── Safari / WebKit ───────────────────────────────────────────────────────────
# Enable dev menu and Web Inspector
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true

# ── Restart affected apps ─────────────────────────────────────────────────────
echo "Restarting affected apps..."
for app in "Dock" "Finder" "SystemUIServer"; do
  killall "$app" &>/dev/null || true
done

echo "Done. Some changes require a logout/reboot to take effect."
