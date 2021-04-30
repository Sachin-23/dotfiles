
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/s4ch1n/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# 
PS1="%F{#00FFFF}%M%f %F{#ffff00}%~%f%(?.. %F{red}%?%f) %F{#FFFFFF}>>%f "; export PS1

# path
export PATH=$PATH:/home/s4ch1n/.local/bin

bindkey -v '^?' backward-delete-char

# ls colors
LS_COLORS=$LS_COLORS:"di=00;33:ex=00;31:ln=00;32"; export LS_COLORS

# set editor as nvim
export EDITOR="vi"
export BROWSER="firefox"

# set some useful alias
alias ls="ls --color"

# set bare repo
alias bare='/usr/bin/git --git-dir=$HOME/.config/dotfiles/ --work-tree=$HOME'

# source bash insulter
if [ -f /etc/bash.command-not-found ]; then
    . /etc/bash.command-not-found
fi

# alias nvim as v
#alias vi="nvim"
#alias sudo="sudo "
alias tools="cd ~/.tools/"
alias config="cd ~/.config/"
alias open="xdg-open"
alias l="ls -la"
alias zettel="vi ~/zettel/main.md"

# locale 
LANG=en_US.UTF-8

# motivate
motivate

export ANDROID_HOME=$HOME/.Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
