HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY

#
bindkey -v
bindkey '^[[Z' reverse-menu-complete

setopt AUTO_CD EXTENDED_GLOB NO_MATCH MENU_COMPLETE

# completions
autoload -Uz compinit
zstyle ':completion:*' menu select
compinit

# zsh-completions & autosuggestions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  #source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  autoload -Uz compinit
  compinit
fi

# prompt 
PROMPT='%F{cyan}%n%f %F{yellow}%~%f%(?.. %F{red}%?%f) %F{white}λ%f ';

# alias
alias vi="nvim"
alias ls="eza"
alias tree="eza --tree"
alias bat="cat"
alias grep="rg"

# confirm before overwriting files
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

# zoxide
eval "$(zoxide init zsh)"
alias cd="z"

# set editor as vi
export EDITOR="vi"

# motivate
/opt/motivate/motivate.py

# fzf
eval "$(fzf --zsh)"

# direnv
eval "$(direnv hook zsh)"

# iterm shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# bun completions
[ -s "/Users/s4ch1n/.bun/_bun" ] && source "/Users/s4ch1n/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# node
export PATH="/opt/homebrew/opt/node@20/bin:$PATH"

# Android Studio
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Add local binary
export PATH="$HOME/.local/bin:$PATH"

################################################################################

# TMUX
# _not_inside_tmux() { [[ -z "$TMUX" ]] }
#
# ensure_tmux_is_running() {
#   if _not_inside_tmux; then
#     tat
#   fi
# }
#
# ensure_tmux_is_running

# git info
# autoload -Uz vcs_info
# #zstyle ':vcs_info:*' enable git 
#
# # setup a hook that runs before every prompt. 
# #precmd_vcs_info() { vcs_info }
# #precmd_functions+=( precmd_vcs_info )
# precmd() { vcs_info }
# setopt prompt_subst
#
# zstyle ':vcs_info:*' enable git
# zstyle ':vcs_info:git*:*' get-revision true
# zstyle ':vcs_info:*' check-for-changes true
# zstyle ':vcs_info:*' stagedstr "+"
#
# zstyle ':vcs_info:git:*' formats '%F{red}%c%f(%b|%.10i)'
# zstyle ':vcs_info:git:*' actionformats '%F{red}%c%f(%b|%.10i)'
#
# # add a function to check for untracked files in the directory.
# # from https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples
# #zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
# #zstyle ':vcs_info:git:*' formats "%c%u%b"
#
# zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
# +vi-git-untracked(){
#     if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
#         git status --porcelain | grep -q '^?? ' 2> /dev/null ; then
#         # This will show the marker if there are any untracked files in repo.
#         # If instead you want to show the marker only if there are untracked
#         # files in $PWD, use:
#         #[[ -n $(git ls-files --others --exclude-standard) ]] ; then
#         hook_com[staged]='*'
#     fi
# }
#
# RPROMPT='${vcs_info_msg_0_}'

