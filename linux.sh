#!/usr/bin/env bash

set -ueo pipefail

# https://arslan.io/2019/07/03/how-to-write-idempotent-bash-scripts/

check_or_install () {
	if ! [ -x "$(command -v $1)" ]; then
		echo "not found $1, try to install it"
		sudo pacman -S $1
	fi
}

echo "install dotfiles"

echo "setup nvim"
check_or_install "nvim"

mkdir -p $HOME/.config/nvim/ 
mkdir -p $HOME/.config/coc/ 
ln -fsn $PWD/init.vim $HOME/.config/nvim/init.vim 
ln -fsn $PWD/coc-settings.json $HOME/.config/nvim/coc-settings.json 

[ ! -f $HOME/.local/share/nvim/site/autoload/plug.vim ] && \
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "setup tmux"
check_or_install "tmux"
ln -fsn $PWD/.tmux.conf $HOME/.tmux.conf
[ ! -d $HOME/.tmux/plugins ] && \
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm


echo "setup git config"
ln -fsn $PWD/.gitignore $HOME/.gitignore
ln -fsn $PWD/.gitconfig $HOME/.gitconfig

echo "setup zsh"
[ ! -f $HOME/.zshrc ] && \
    ln -s $PWD/.zshrc $HOME/.zshrc

ln -fsn $PWD/.p10k.zsh $HOME/.p10k.zsh
ln -fsn $PWD/.ripgreprc $HOME/.ripgreprc

echo "setup nvm"
[ ! -d $HOME/.nvm ] && \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash

echo "finish dotfiles"

