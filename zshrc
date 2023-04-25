# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/powerlevel10k/powerlevel10k.zsh-theme

PATH="~/.composer/vendor/bin:$PATH"

PATH="$PATH:/Users/remmelt/.local/bin"

PATH="/opt/homebrew/bin:$PATH"
PATH="/opt/homebrew/sbin:$PATH"
PATH="/opt/homebrew/opt/curl/bin:$PATH"
PATH="/opt/homebrew/opt/sqlite/bin:$PATH"

PATH="/Users/remmelt/go/bin:$PATH"
PATH="/opt/homebrew/opt/node@16/bin:$PATH"

PATH="/Users/remmelt/.bin:$PATH"

export PATH=$PATH

export EDITOR=vim

bindkey -v
bindkey -M viins '\e.' insert-last-word

# Docker
alias aq='docker rm -fv $(docker ps -aq)'
alias dl='docker ps -lq'
alias prune='docker system prune -f'
alias dc='docker-compose'

alias t='terraform'

# Python
alias pu='poetry lock --no-update && poetry install --no-root --sync'

# Git
alias gpp='gh pr create --fill'
alias gs='git status --short --branch'
alias gd='git diff'
alias gdc='git diff --cached'
alias ga='(gr && git add .)'
alias gca='git commit --amend'
alias gu='git up'
alias gub='gm && gu && g- && git rebase -i $(git merge-base head main)'
alias g-='git checkout -'
alias gm='git rev-parse --verify --quiet main > /dev/null && git checkout main || git checkout master'
alias gco='git checkout'
alias gc='git commit'
alias gl='git log -1 --stat'
alias gb='git branch'
alias gcb='ff() { git checkout -b ${1} $(gh repo view --json defaultBranchRef | jq -r ".defaultBranchRef.name") };ff'
alias gwip='ga && git commit -m"autoWIP" -n --no-verify'
alias gr='cd $(git rev-parse --show-toplevel)'
alias gsu='git submodule update --init --recursive'

alias note='note() { d=$(date +"%Y%m%d"); concat=${$(printf '%s-' ${@})%?}; file="/Users/remmelt/dev/source/notes/${d}-${concat}.md"; touch "$file"; code "$file" }; note'

alias i='idea .'
alias g='goland .'
alias p='pycharm .'
alias c='code .'
alias z='fasd_cd'
alias ls='exa -a -a -l --git'
alias l='ls'
alias grep='grep --color'
alias hist='history -150'

alias o='open .'

alias awslocal="aws --endpoint-url=http://localhost:4566 --profile=localstack"

source ~/.zsh_options

eval $(thefuck --alias fu)
eval "$(fasd --init auto)"
eval "$(jenv init -)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# fxf & fd options
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="fd --type file --color=always"
export FZF_DEFAULT_OPTS="--ansi"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

zstyle ':completion:*' list-suffixeszstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

# The next line updates PATH for the Google Cloud SDK.
source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"

# The next line enables shell command completion for gcloud.
source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform


eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

source <(inv --print-completion-script zsh)

# source /Users/remmelt/.config/op/plugins.sh

source /Users/remmelt/.docker/init-zsh.sh || true # Added by Docker Desktop


