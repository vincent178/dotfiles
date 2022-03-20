source $HOME/.scripts/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle command-not-found

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle agkozak/zsh-z

# Load the theme.
antigen theme robbyrussell

antigen apply

export EDITOR="nvim"
export BROWSER="chromium"

export http_proxy="http://localhost:7890"
export https_proxy="http://localhost:7890"

export PATH=$PATH:$HOME/go/bin:$HOME/.rvm/bin

alias v="nvim"
alias n="neofetch"
alias f="fzf"
alias r="ranger"

source /usr/share/nvm/init-nvm.sh
source $HOME/.rvm/scripts/rvm

