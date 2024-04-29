source /opt/homebrew/share/antigen/antigen.zsh

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
export BROWSER="firefox"

alias kamal='docker run -it --rm -v "${PWD}:/workdir" -v "/run/host-services/ssh-auth.sock:/run/host-services/ssh-auth.sock" -e SSH_AUTH_SOCK="/run/host-services/ssh-auth.sock" -v /var/run/docker.sock:/var/run/docker.sock ghcr.io/basecamp/kamal:latest'
alias v="nvim"
alias f="fzf"
alias r="ranger"

if [ -d "$HOME/.rvm" ]; then
    source $HOME/.rvm/scripts/rvm
fi

export GOPATH="$HOME/.go"
export GOBIN="$GOPATH/bin"

export NODE_MIRROR=https://mirrors.tuna.tsinghua.edu.cn/nodejs-release/

# MacOS arm only
if [ "$(uname)" = "Darwin" ]; then
  eval $(/opt/homebrew/bin/brew shellenv)

  alias brew='/opt/homebrew/bin/brew'
  alias abrew='/opt/homebrew/bin/brew'
  alias ibrew='arch -x86_64 /usr/local/bin/brew'
  alias pbcopy="LANG=zh-CN.UTF-8 pbcopy"

  export HOMEBREW_INSTALL_FROM_API=1
  export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
  export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
  export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
  export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
  
  export LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib"
  export CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include"
  export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@3/lib/pkgconfig"

  export DYLD_LIBRARY_PATH="$(brew --prefix)/lib:$DYLD_LIBRARY_PATH"
fi

if [ "$TERM_PROGRAM" = "iTerm.app" ]; then
    tmux has -t hack &> /dev/null
    if [ $? -ne 0 ]; then
        tmux new -s hack
    elif [ -z $TMUX ]; then
        tmux attach -t hack
    fi
fi

__conda_setup="$("$HOME/Miniconda3/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/Miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/Miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/Miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -d "$HOME/.local/bin" ]; then
  export PATH=$HOME/.local/bin:$PATH
fi

if [ -d "$HOME/go/bin" ]; then
fi

if [ -d "$HOME/.cargo/bin" ]; then
  export PATH=$HOME/.cargo/bin:$PATH
fi

if [ -d "$HOME/.rvm/bin" ]; then
    export PATH="$HOME/.rvm/bin:$PATH"
fi

if [ -f "$HOME/.nvm/nvm.sh" ]; then
    source $HOME/.nvm/nvm.sh
fi

if [ -f "$HOME/.custom.sh" ]; then
    source $HOME/.custom.sh
fi

export PATH=$GOBIN:$PATH
