# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Setup

Run `./install.sh` to symlink all dotfiles into place. The script is idempotent and backs up existing non-symlink files with a `.bak` suffix before linking.

To apply macOS system preferences: `./macos/macos.sh`

To install all Homebrew packages: `brew bundle install --file=Brewfile`

## How It Works

Configs live in topic directories (`zsh/`, `git/`, `ssh/`, `starship/`, `macos/`) and are manually symlinked by `install.sh` to their expected locations in `$HOME`. No dotfile manager (stow, chezmoi, etc.) is used.

## Key Files and Their Destinations

| Source | Destination |
|--------|-------------|
| `zsh/.zshrc` | `~/.zshrc` |
| `zsh/.zprofile` | `~/.zprofile` |
| `git/.gitconfig` | `~/.gitconfig` |
| `git/.gitignore_global` | `~/.gitignore_global` |
| `ssh/config` | `~/.ssh/config` |
| `starship/starship.toml` | `~/.config/starship.toml` |

## Adding a New Config

1. Create a topic directory (or reuse an existing one)
2. Add the config file
3. Add a symlink entry to `install.sh` following the existing `ln -sf` pattern

## SSH

All SSH connections use the 1Password SSH agent (`~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock`). The agent must be running for SSH/Git operations to work.
