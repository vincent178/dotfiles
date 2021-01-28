export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

DISABLE_AUTO_UPDATE="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

alias abrew='/opt/homebrew/bin/brew'
alias ibrew='arch -x86_64 /usr/local/bin/brew'

# Homebrew
eval $(/opt/homebrew/bin/brew shellenv)

# PATH
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin

proxy() {
  export http_proxy=192.168.50.152:7890
  export https_proxy=192.168.50.152:7890
  export sock_proxy=192.168.50.152:7890
}

unproxy() {
  unset http_proxy
  unset https_proxy
  unset sock_proxy
}

