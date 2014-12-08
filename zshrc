# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# theme
ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# custom configuration
[[ -s "$HOME/.custom" ]] && source "$HOME/.custom"

# alias
alias ws='cd ~/Documents/workspace/'

# path
export GOPATH=$HOME/Documents/workspace/go

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export PATH=$PATH:$GOPATH/bin
