# === History ===
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
# setopt INC_APPEND_HISTORY
# setopt SHARE_HISTORY

# === Keybindings ===
bindkey -v
bindkey '^[[Z' reverse-menu-complete

# === Options ===
setopt AUTO_CD
setopt EXTENDED_GLOB
setopt NO_MATCH
setopt MENU_COMPLETE

# === Completions ===
autoload -Uz compinit
zstyle ':completion:*' menu select
compinit

# === Plugins ===
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh-completions:$FPATH"
  
  # Autosuggestions
  if [ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  fi

  # Syntax Highlighting (must be sourced *last*)
  if [ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  fi
fi

# === Prompt ===
PROMPT='%F{cyan}%n%f %F{yellow}%~%f%(?.. %F{red}%?%f) %F{white}λ%f '

# === Aliases ===
alias vi='nvim'
alias ls='eza'
alias tree='eza --tree'
alias bat='cat'
alias grep='rg'

alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

# === zoxide ===
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
  alias cd='z'
fi


# === fzf ===
eval "$(fzf --zsh)"

# === direnv ===
eval "$(direnv hook zsh)"

# === iterm shell integration ===
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# === Add local binary ===
export PATH="$HOME/.local/bin:$PATH"

# === Motivate ===
/opt/motivate/motivate.py


