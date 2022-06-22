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

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export EDITOR="nvim"
export BROWSER="chromium"

alias v="nvim"
alias n="neofetch"
alias f="fzf"
alias r="ranger"

# MacOS arm only
if [ "$(uname)" = "Darwin" ]; then
  eval $(/opt/homebrew/bin/brew shellenv)

  alias brew='arch -arm64 /opt/homebrew/bin/brew'
  alias abrew='/opt/homebrew/bin/brew'
  alias ibrew='arch -x86_64 /usr/local/bin/brew'
  alias bundle="arch -x86_64 bundle"
  alias npm="arch -x86_64 npm"
  alias pnpm="arch -x86_64 pnpm"
  alias gem="arch -x86_64 gem"
  alias pbcopy="LANG=zh-CN.UTF-8 pbcopy"
fi

export PATH=$HOME/go/bin:$HOME/.cargo/bin:$PATH

source $HOME/.nvm/nvm.sh
source $HOME/.rvm/scripts/rvm

