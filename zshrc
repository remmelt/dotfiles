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

PATH="~/.composer/vendor/bin:$PATH"

# Homebrew:
if [ 'arm64' = "$(uname -m)" ]; then
  PATH="/opt/homebrew/bin:$PATH"
  PATH="/opt/homebrew/opt/curl/bin:$PATH"
  PATH="/opt/homebrew/opt/sqlite/bin:$PATH"
else
  PATH="/usr/local/bin:/usr/local/sbin:$PATH"
  PATH="/usr/local/opt/mysql-client/bin:$PATH"
  PATH="/usr/local/opt/curl/bin:$PATH"
fi

PATH="/Users/remmelt/dev/go/bin:$PATH"
PATH="/Users/remmelt/.bin:$PATH"

export PATH=$PATH

export GOPATH="/Users/remmelt/dev/go"

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
alias gm='git rev-parse --verify --quiet main > /dev/null && git checkout main || git checkout master'
alias gco='git checkout'
alias gc='git commit'
alias gl='git log -1 --stat'
alias gb='git branch'
alias gcb='ff() { git rev-parse --verify --quiet main > /dev/null && M=main || M=master; git checkout -b ${1} $M };ff'
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

# fxf & fd options
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="fd --type file --color=always"
export FZF_DEFAULT_OPTS="--ansi"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

zstyle ':completion:*' list-suffixeszstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc' ]; then . '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc' ]; then . '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'; fi
