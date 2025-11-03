
# Homebrew paths
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"

# Default editor
export EDITOR="nvim"
export VISUAL="nvim"

# Editor shortcuts
alias vim='nvim'
alias vi='nvim'
alias v='nvim'

# Development
alias dc='docker compose'
alias k='kubectl'

# Switcher tool (after compinit)
if command -v switcher >/dev/null 2>&1; then
  source <(switcher init zsh)
fi

if command -v switch >/dev/null 2>&1; then
  source <(switch completion zsh)
fi

# Homebrew completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

if command -v eza &> /dev/null; then
  alias ls='eza -lh --group-directories-first --icons=auto'
  alias lsa='ls -a'
  alias lt='eza --tree --level=2 --long --icons --git'
  alias lta='lt -a'
fi

alias ff="fzf --preview 'bat --style=numbers --color=always {}'"

if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
  alias cd="zd"
  zd() {
    if [ $# -eq 0 ]; then
      builtin cd ~ && return
    elif [ -d "$1" ]; then
      builtin cd "$1"
    else
      z "$@" && printf "\U000F17A9 " && pwd || echo "Error: Directory not found"
    fi
  }
fi
