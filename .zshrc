PATH="$PATH:/Users/remmeltpit/.local/bin"

PATH="/opt/homebrew/bin:$PATH"
PATH="/opt/homebrew/sbin:$PATH"
PATH="/opt/homebrew/opt/curl/bin:$PATH"
PATH="$HOME/.jenv/bin:$PATH"
PATH="/opt/homebrew/opt/node@18/bin:$PATH"
PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

PATH="/Users/remmeltpit/.bin:$PATH"

export GROWTH_DEPLOY_K8S_PATH="/Users/remmeltpit/dev/bitvavo/growth/k8s-configs"

export PATH=$PATH

export EDITOR=vim

export BAT_THEME="Monokai Extended"

# export GITHUB_TOKEN="op://Private/GitHub Personal Access Token/token"
export OPENAI_API_KEY="op://Private/CommitGPT OpenAI API key/password"
# wherever GITHUB_TOKEN is referenced, prefix command with `op run -- `

bindkey -v
bindkey -M viins '\e.' insert-last-word

# Aliases
alias tf=terraform

# Docker
alias aq='docker ps -aq | xargs -n1 docker rm -fv'
alias dl='docker ps -lq'
alias prune='docker system prune -f'
alias dc='docker-compose'

alias gw='./gradlew'

# Git
# alias gh='op run -- gh'
alias gs='git status --short --branch'
alias gd='git diff'
alias gdc='git diff --cached'
alias ga='(gr && git add .)'
alias gca='git commit --amend'
alias gu='git up'
alias g-='git checkout -'
alias gco='git checkout'
alias gc='git commit'
alias gl='git log -1 --stat'
alias gbb='ff() { git branch --sort=-committerdate | fzf -q "${1}" | xargs git checkout }; ff'
alias gcb='ff() { git checkout -b ${1} $(github-default-branch) };ff'
alias gflat='git rebase -i $(git merge-base --fork-point $(github-default-branch))'
alias gwip='ga && git commit -m"autoWIP" --no-verify'
alias gr='cd $(git rev-parse --show-toplevel)'
alias gsu='git submodule update --init --recursive'

# Kube
alias k=kubectl
alias kprof="kubectl config get-contexts --no-headers | tr '*' ' ' | fzf --nth 1 | awk '{print \$1}' | xargs kubectl config use-context"

# https://github.com/gennaro-tedesco/gh-f
alias prs='gh f -p'
alias glf='gh f -l'
# https://github.com/dlvhdr/gh-dash
alias dash='gh dash'

alias note='note() { d=$(date +"%Y%m%d"); concat=${$(printf '%s-' ${@})%?}; file="/Users/remmeltpit/dev/bitvavo/notes/${d}-${concat}.md"; touch "$file"; code "$file" }; note'

alias i='idea .'
alias c='code .'
alias ls='eza -a -a -l --git'
alias l='ls'
alias grep='grep --color'
alias hist='history -150'
alias cat=bat
alias o='open .'
alias z='fasd_cd'

source ~/.zsh_options

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="fd --type file --color=always"
export FZF_DEFAULT_OPTS="--no-mouse --color='dark,bg+:red'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

zstyle ':completion:*' list-suffixeszstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

eval "$(fasd --init auto)"
eval "$(jenv init -)"

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit

source /Users/remmeltpit/dev/side/dotfiles/tsh-bitvavo.sh

eval "$(starship init zsh)"
