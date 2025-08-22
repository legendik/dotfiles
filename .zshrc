# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ============================================================================
# ENVIRONMENT SETUP
# ============================================================================

# Homebrew paths
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"

# Default editor
export EDITOR="nvim"
export VISUAL="nvim"

# Better history
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE="$HOME/.zsh_history"
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS

# Better directory navigation
setopt AUTO_CD              # cd by typing directory name if it's not a command
setopt AUTO_PUSHD           # Make cd push old directory to directory stack
setopt PUSHD_IGNORE_DUPS    # Don't push duplicates to directory stack
setopt PUSHD_SILENT         # Don't print directory stack after pushd or popd

# Completion improvements
setopt COMPLETE_IN_WORD     # Complete from both ends of a word
setopt ALWAYS_TO_END        # Move cursor to end if word had one match
setopt AUTO_MENU            # Automatically use menu completion
setopt AUTO_LIST            # Automatically list choices on ambiguous completion

# ============================================================================
# COMPLETION SYSTEM
# ============================================================================

# Initialize completion system early (fixes compdef errors)
autoload -Uz compinit
compinit

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # Case insensitive completion
zstyle ':completion:*' list-colors ''                   # Use colors in completion
zstyle ':completion:*:*:*:*:*' menu select              # Use menu for completion
zstyle ':completion:*' special-dirs true                # Complete . and .. special dirs
zstyle ':completion:*' squeeze-slashes true             # Remove extra slashes

# ============================================================================
# PROMPT THEME
# ============================================================================

source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ============================================================================
# NODE.JS / NVM SETUP
# ============================================================================

export NVM_DIR="$HOME/.nvm"

# Load default node version immediately (lightweight)
export PATH="$NVM_DIR/versions/node/$(cat $NVM_DIR/alias/default 2>/dev/null || echo 'v22.0.0')/bin:$PATH"

# Lazy load full nvm functionality
nvm() {
  unset -f nvm node npm npx
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
  nvm "$@"
}

# Create placeholder functions that trigger nvm loading
node() { nvm >/dev/null 2>&1 && node "$@"; }
npm() { nvm >/dev/null 2>&1 && npm "$@"; }
npx() { nvm >/dev/null 2>&1 && npx "$@"; }

# ============================================================================
# ZSH PLUGINS & ENHANCEMENTS
# ============================================================================

# fzf - Fuzzy finder
if command -v fzf >/dev/null 2>&1; then
  # Set up fzf key bindings and fuzzy completion
  source <(fzf --zsh)
  
  # Use fd for fzf if available (faster and respects .gitignore)
  if command -v fd >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
  fi
  
  # fzf options for better UX
  export FZF_DEFAULT_OPTS='
    --height 40% 
    --layout=reverse 
    --border 
    --preview "bat --style=numbers --color=always --line-range :500 {}" 2>/dev/null || cat {}
    --preview-window=right:50%:wrap
    --bind "ctrl-y:execute-silent(echo {} | pbcopy)"
    --color=fg:#c0caf5,bg:#1a1b26,hl:#bb9af7
    --color=fg+:#c0caf5,bg+:#292e42,hl+:#7dcfff
    --color=info:#7aa2f7,prompt:#7dcfff,pointer:#bb9af7
    --color=marker:#9ece6a,spinner:#bb9af7,header:#73daca'
fi

# zsh-autosuggestions
if [[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  # Configuration for autosuggestions
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'  # Gray color for suggestions
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)
  ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
fi

# zsh-syntax-highlighting (must be at the end)
if [[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  # Configuration for syntax highlighting
  ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
  ZSH_HIGHLIGHT_STYLES[command]='fg=green'
  ZSH_HIGHLIGHT_STYLES[alias]='fg=green'
  ZSH_HIGHLIGHT_STYLES[builtin]='fg=green'
  ZSH_HIGHLIGHT_STYLES[function]='fg=green'
  ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'
  ZSH_HIGHLIGHT_STYLES[globbing]='fg=yellow'
fi

# ============================================================================
# ALIASES
# ============================================================================

# Better defaults
alias ls='ls -G'                    # Colorize ls output
alias ll='ls -laFh'                 # Long format, all files, human readable
alias la='ls -A'                    # All files except . and ..
alias l='ls -CF'                    # Columnar format

# Directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias home='cd ~'
alias -- -='cd -'                  # Go to previous directory

# Git shortcuts
alias g='git'
alias ga='git add'
alias gc='git commit'
alias gcm='git commit -m'
alias gco='git checkout'
alias gd='git diff'
alias gl='git log --oneline'
alias gp='git push'
alias gpl='git pull'
alias gs='git status'
alias gb='git branch'

# Editor shortcuts
alias vim='nvim'
alias vi='nvim'
alias v='nvim'

# fzf shortcuts
alias fzp='fzf --preview "bat --style=numbers --color=always --line-range :500 {}"'
alias fzd='fd --type d | fzf'

# Development
alias serve='python3 -m http.server 8000'
alias dc='docker-compose'
alias k='kubectl'

# ============================================================================
# FUNCTIONS
# ============================================================================

# Create directory and cd into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Find and kill process by name
killport() {
  if [[ -z "$1" ]]; then
    echo "Usage: killport <port>"
    return 1
  fi
  lsof -ti tcp:$1 | xargs kill -9
}

# fzf enhanced cd
fcd() {
  local dir
  dir=$(fd --type d | fzf +m) && cd "$dir"
}

# fzf enhanced file editing
fv() {
  local file
  file=$(fzf +m -q "$1") && nvim "$file"
}

# fzf git checkout branch
fco() {
  local branch
  branch=$(git branch --all | grep -v HEAD | sed "s/.* //" | sed "s#remotes/[^/]*/##" | sort -u | fzf +m) &&
  git checkout $(echo "$branch" | sed "s#origin/##" | head -1)
}

# fzf history search (enhanced Ctrl+R)
fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

# ============================================================================
# KEY BINDINGS
# ============================================================================

# Custom key bindings for fzf functions
bindkey '^f' fcd    # Ctrl+F for fuzzy cd
bindkey '^v' fv     # Ctrl+V for fuzzy file edit

# ============================================================================
# EXTERNAL TOOL INTEGRATIONS
# ============================================================================

# Load local secrets (create ~/.zshrc.local for machine-specific config)
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

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
