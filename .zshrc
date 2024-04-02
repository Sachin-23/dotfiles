# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile HISTSIZE=10000
SAVEHIST=10000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/s4ch1n/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# prompt 
PS1='%F{cyan}%n%f %F{yellow}%~%f%(?.. %F{red}%?%f) %F{white}>>%f '; export PS1

alias vi="nvim"
alias ls="ls --color"
#alias cd="zoxide"

# set editor as nvim
export EDITOR="vi"

# motivate
/opt/motivate/motivate.py

export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

#export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
#export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

eval "$(zoxide init zsh)"
alias cd="z"

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
