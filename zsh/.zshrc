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
antigen theme ys

antigen apply

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export EDITOR="nvim"
export BROWSER="firefox"

alias v="nvim"
alias f="fzf"
alias r="ranger"

if [ -d "$HOME/.rvm" ]; then
    source $HOME/.rvm/scripts/rvm
fi

export GOPATH="$HOME/.go"

export NODE_MIRROR=https://mirrors.tuna.tsinghua.edu.cn/nodejs-release/

# MacOS arm only
if [ "$(uname)" = "Darwin" ]; then
  eval $(/opt/homebrew/bin/brew shellenv)

  alias brew='/opt/homebrew/bin/brew'
  alias abrew='/opt/homebrew/bin/brew'
  alias ibrew='arch -x86_64 /usr/local/bin/brew'
  # alias npm="arch -x86_64 npm"
  # alias pnpm="arch -x86_64 pnpm"
  alias pbcopy="LANG=zh-CN.UTF-8 pbcopy"

  export HOMEBREW_INSTALL_FROM_API=1
  export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
  export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
  export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
  export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
fi

# ruby:node:go:rust
export PATH="$HOME/.rvm/bin:$HOME/.n/bin:$HOME/go/bin:$HOME/.cargo/bin:$PATH"


