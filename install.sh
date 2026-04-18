#!/usr/bin/env bash
# Dotfiles install script — idempotent, safe to re-run
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

green()  { printf "\033[32m%s\033[0m\n" "$*"; }
yellow() { printf "\033[33m%s\033[0m\n" "$*"; }
red()    { printf "\033[31m%s\033[0m\n" "$*"; }

link() {
  local src="$1" dst="$2"
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    yellow "  already linked: $dst"
    return
  fi
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    yellow "  backing up existing: $dst → $dst.bak"
    mv "$dst" "$dst.bak"
  fi
  mkdir -p "$(dirname "$dst")"
  ln -sf "$src" "$dst"
  green "  linked: $dst → $src"
}

echo ""
echo "==> Symlinking dotfiles from $DOTFILES"

# Zsh
link "$DOTFILES/zsh/.zshrc"    "$HOME/.zshrc"
link "$DOTFILES/zsh/.zprofile" "$HOME/.zprofile"

# Git
link "$DOTFILES/git/.gitconfig"       "$HOME/.gitconfig"
link "$DOTFILES/git/.gitignore_global" "$HOME/.gitignore_global"

# SSH
link "$DOTFILES/ssh/config" "$HOME/.ssh/config"

# Starship
mkdir -p "$HOME/.config"
link "$DOTFILES/starship/starship.toml" "$HOME/.config/starship.toml"

echo ""
echo "==> Installing Homebrew packages"
if command -v brew &>/dev/null; then
  brew bundle install --file="$DOTFILES/Brewfile"
else
  red "  Homebrew not found — install it first: https://brew.sh"
fi

echo ""
echo "==> Touch ID for sudo"
if [ ! -f /etc/pam.d/sudo_local ]; then
  echo "auth       sufficient     pam_tid.so" | sudo tee /etc/pam.d/sudo_local > /dev/null
  green "  enabled Touch ID for sudo"
else
  yellow "  /etc/pam.d/sudo_local already exists, skipping"
fi

echo ""
green "Done! Open a new shell to pick up changes."
echo "Optionally run: bash ~/.dotfiles/macos/macos.sh"
