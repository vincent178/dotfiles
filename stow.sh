
stow zsh -t $HOME
stow tmux -t $HOME
stow scripts -t $HOME

mkdir -p $HOME/.config

stow config -t $HOME/.config

