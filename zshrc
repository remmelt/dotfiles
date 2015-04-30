#!/bin/zsh

autoload -U promptinit compinit 
compinit
promptinit
prompt adam1

export LC_CTYPE="en_US.utf-8"

alias ls='ls -lAsGhF'
alias grep='grep --color'
alias history='history -150'

setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt autocd
setopt extendedglob
export HISTSIZE=2000
export HISTFILE="$HOME/.history"

zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

