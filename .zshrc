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

# === Git ===
autoload -Uz vcs_info

# Show changes with a '*' before the prompt
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' get-revision true
zstyle ':vcs_info:git:*' check-for-untracked-files true

zstyle ':vcs_info:git:*' stagedstr '*'
zstyle ':vcs_info:git:*' unstagedstr '*'
zstyle ':vcs_info:git:*' formats '%u%c(%b|%.10i)'
zstyle ':vcs_info:git:*' actionformats '%u%c(%b|%.10i)'

precmd_vcs_info() { vcs_info }
precmd_functions+=precmd_vcs_info

setopt prompt_subst
RPROMPT='${vcs_info_msg_0_}'
