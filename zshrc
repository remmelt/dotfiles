#!/bin/zsh

autoload -U promptinit compinit
compinit
promptinit
prompt adam1

export LC_CTYPE="en_US.utf-8"

alias ls='ls -lAshF'
alias grep='grep --color'
alias history='history -150'
alias aq='docker rm -fv $(docker ps -aq)'
alias dl='docker ps -lq'
alias dang='docker rmi $(docker images -f "dangling=true" -q)'

setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt autocd
setopt extendedglob
export SAVEHIST=1000
export HISTSIZE=2000
export HISTFILE="$HOME/.history"
export clobber

zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
		man "$@"
}

