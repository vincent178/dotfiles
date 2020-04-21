#!/usr/bin/env bash

set -ueo pipefail

check_or_install () {
	if ! [ -x "$(command -v $1)" ]; then
		echo "not found $1, try to install it"
		sudo apt-get install -y $1
	fi
}

echo "install dotfiles"

echo "setup nvim"
check_or_install "nvim"

[ ! -d $HOME/.config/nvim/ ] && \
    mkdir $HOME/.config/nvim/ && \
    mkdir $HOME/.config/coc/ && \
    ln -s $PWD/init.vim $HOME/.config/nvim/init.vim && \
    ln -s $PWD/coc-settings.json $HOME/.config/nvim/coc-settings.json && \
    ln -s $PWD/coc $HOME/.config/coc

[ ! -f $HOME/.local/share/nvim/site/autoload/plug.vim ] && \
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "setup tmux"
check_or_install "tmux"
[ ! -f $HOME/.tmux.conf ] && \
	ln -s $PWD/.tmux.conf $HOME/.tmux.conf
[ ! -d $HOME/.tmux/plugins ] && \
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm


echo "setup git config"
[ ! -f $HOME/.gitignore ] && \
	ln -s $PWD/.gitignore $HOME/.gitignore
[ ! -f $HOME/.gitconfig ] && \
	ln -s $PWD/.gitconfig $HOME/.gitconfig

echo "setup zsh"
[ ! -f $HOME/.zshrc ] && \
    ln -s $PWD/.zshrc $HOME/.zshrc
[ ! -f $HOME/.p10k.zsh ] && \
    ln -s $PWD/.p10k.zsh $HOME/.p10k.zsh

[ ! -f $HOME/.ripgreprc ] && \
    ln -s $PWD/.ripgreprc $HOME/.ripgreprc

echo "setup nvm"
[ ! -d $HOME/.nvm ] && \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash

echo "finish dotfiles"

