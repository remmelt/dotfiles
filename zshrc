# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/powerlevel10k/powerlevel10k.zsh-theme

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  autoload -Uz compinit
  compinit
fi

export PATH=~/.bin:$HOME/.jenv/bin:/opt/local/bin:/opt/local/sbin:$PATH

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

source ~/.zsh_options

eval $(thefuck --alias fu)
eval "$(fasd --init auto)"
eval "$(jenv init -)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

zstyle ':completion:*' list-suffixeszstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
