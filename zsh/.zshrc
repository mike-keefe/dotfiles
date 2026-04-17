# ── History ──────────────────────────────────────────────────────────────────
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS       # don't record duplicate consecutive commands
setopt HIST_IGNORE_SPACE      # commands prefixed with a space aren't saved
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY          # share history across sessions

# ── pyenv ─────────────────────────────────────────────────────────────────────
export PYENV_ROOT="$HOME/.pyenv"
[[ -d "$PYENV_ROOT/bin" ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# ── nvm ───────────────────────────────────────────────────────────────────────
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# ── pnpm ──────────────────────────────────────────────────────────────────────
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# ── Completions ───────────────────────────────────────────────────────────────
autoload -Uz compinit && compinit

# ── Aliases ───────────────────────────────────────────────────────────────────
alias ll='ls -lAhG'
alias la='ls -AG'
alias ..='cd ..'
alias ...='cd ../..'
alias gs='git status'
alias gd='git diff'
alias gp='git push'
alias gl='git pull'

# ── Starship prompt ───────────────────────────────────────────────────────────
eval "$(starship init zsh)"
