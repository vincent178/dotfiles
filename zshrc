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
alias chi='cd ~/Documents/Excelsior/Code/'
alias vi='vim'
alias fuck='eval $(thefuck $(fc -ln -1 | tail -n 1)); fc -R'
alias java_ls='/usr/libexec/java_home -V 2>&1 | grep -E "\d.\d.\d[,_]" | cut -d , -f 1 | colrm 1 4 | grep -v Home'

function java_use() {
  export JAVA_HOME=$(/usr/libexec/java_home -v $1)
  export PATH=$JAVA_HOME/bin:$PATH
  java -version
}

# docker
eval `boot2docker shellinit 2>/dev/null`

# path
export GOPATH=$HOME/Library/Development/Go

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH=$HOME/.rvm/bin:$PATH # Add RVM to PATH for scripting
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export PATH=$PATH:$GOPATH/bin

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
