#!/bin/bash

set -e

check_or_install () {
	if ! [ -x "$(command -v $1)" ]; then
		echo "not found $1, try to install it"
		sudo apt-get install -y $1
	fi
}

echo "install dotfiles"

echo "setup nvim"
check_or_install "nvim"

if ! [ -d $HOME/.config/nvim/ ]; then
	mkdir $HOME/.config/nvim/
fi

if ! [ -f $HOME/.config/nvim/init.vim ]; then
	ln -s $PWD/init.vim $HOME/.config/nvim/init.vim
fi

if ! [ -f ~/.local/share/nvim/site/autoload/plug.vim ]; then
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

echo "setup tmux"
check_or_install "tmux"
if ! [ -f $HOME/.tmux.conf ]; then
	ln -s $PWD/.tmux.conf $HOME/.tmux.conf
fi

echo "setup git"
if ! [ -f $HOME/.gitignore ]; then
	ln -s $PWD/.gitignore $HOME/.gitignore
fi
if ! [ -f $HOME/.gitconfig ]; then
	ln -s $PWD/.gitconfig $HOME/.gitconfig
fi

echo "setup nvm"
if ! [ -f $HOME/.nvm ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
fi

echo "finish dotfiles"
