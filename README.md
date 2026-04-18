# dotfiles

Mike's macOS dotfiles. Topic-based directory structure, symlinked into place by `install.sh`.

## Bootstrap a new machine

```bash
# 1. Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Clone the repo
git clone https://github.com/mike-keefe/dotfiles.git ~/.dotfiles

# 3. Run the install script (symlinks configs + installs Homebrew packages)
cd ~/.dotfiles && ./install.sh
```

## Apply macOS system preferences

```bash
bash ~/.dotfiles/macos/macos.sh
```

Some changes require a logout or reboot to take effect.

## What's included

| Topic | Files | Purpose |
|-------|-------|---------|
| `zsh/` | `.zshrc`, `.zprofile` | Shell config, aliases, PATH setup |
| `git/` | `.gitconfig`, `.gitignore_global` | Git identity, aliases, SSH signing via 1Password |
| `ssh/` | `config` | SSH via 1Password agent |
| `starship/` | `starship.toml` | Shell prompt config |
| `macos/` | `macos.sh` | macOS system preference defaults |

## Adding a new config

1. Create a topic directory (or reuse an existing one)
2. Add the config file
3. Add a `link` call in `install.sh` following the existing pattern

## Notes

- **SSH + Git signing**: Uses the [1Password SSH agent](https://developer.1password.com/docs/ssh/). The agent must be running for SSH and signed commits to work.
- **nvm**: Installed separately via the [official install script](https://github.com/nvm-sh/nvm#installing-and-updating), not through Homebrew. Run this manually on a new machine after `install.sh`.
- **pyenv**: Installed via Homebrew (in Brewfile). Python versions managed separately with `pyenv install <version>`.
