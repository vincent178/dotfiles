export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

DISABLE_AUTO_UPDATE="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# Homebrew
eval $(/opt/homebrew/bin/brew shellenv)

# User configuration

export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

# https://stackoverflow.com/questions/48308803/how-to-include-ffi-in-os-x
export LDFLAGS="-L/opt/homebrew/opt/libffi/lib -L/opt/homebrew/opt/icu4c/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libffi/include -I/opt/homebrew/opt/icu4c/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/libffi/lib/pkgconfig /opt/homebrew/opt/icu4c/lib/pkgconfig"

alias v="nvim"

# PATH
export PATH=$PATH:/usr/local/bin:/usr/local/go/bin:$HOME/go/bin

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$HOME/.rvm/bin:$PATH"

eval "$(rbenv init -)"
eval "$(/usr/libexec/path_helper)"


export DATABASE_URL=postgres://sneakers@localhost/sneakers_development
