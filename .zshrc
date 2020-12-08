#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

#export MAVEN_OPTS="-Xms1024m -Xmx2048m"
#export GOROOT=$HOME/go1.7
export GOPATH=~/dev/go

export PATH=~/bin:$GOPATH/bin:/opt/apache-maven/bin:/usr/local/bin:/opt/local/bin:/opt/local/sbin:$PATH:/usr/local/sbin:$GOROOT/bin
export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/2.7.0/bin:$PATH"

export DEFAULT_USER=remmelt

export LC_CTYPE="en_US.utf-8"

fpath=(/usr/local/share/zsh-completions $fpath)

alias ssh-addall='find ~/.ssh -type f -name "id_*" -not -name "*.pub" -exec ssh-add {} \+'

# Docker
alias aq='docker rm -fv $(docker ps -aq)'
alias dl='docker ps -lq'
alias prune='docker system prune -f'
alias dc='docker-compose'

# Git
alias gs='git status -sb'
alias gd='git diff'
alias gdc='git diff --cached'
alias ga='(gr && git add .)'
alias gca='git commit --amend'
alias gu='git up'
alias g-='git checkout -'
alias gm='git checkout main'
alias gco='git checkout'
alias gc='git commit'
alias gl='git log -1 --stat'
alias gb='git branch'
alias gcb='f() { git checkout -b ${1} origin/main };f'
alias gwip='ga && git commit -m"autoWIP" -n'
alias gr='cd $(git rev-parse --show-toplevel)'
alias gsu='git submodule update --init --recursive'

alias c='code .'
alias z='fasd_cd'
alias ls='exa -a -a -l --git'
alias l='ls'
alias grep='grep --color'
alias hist='history -150'

alias o='open .'

unsetopt histverify

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

eval $(thefuck --alias fu)

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/nomad nomad

eval "$(jenv init -)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

