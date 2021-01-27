#!/bin/sh

set -e

echo "Setup your Mac..."

check_install() {
	if ! [ -x "$(command -v $1)" ]; then
		echo "$1 not found $1, exit"
		exit 1
	fi
}

check_install "brew"

if [[ "$(uname -a)" == *"x86_64"* ]]; then
	echo "setup nvim"
	check_install "nvim"

	mkdir -p $HOME/.config/nvim/ 
	mkdir -p $HOME/.config/coc/ 
	ln -fsn $PWD/init.vim $HOME/.config/nvim/init.vim 
	ln -fsn $PWD/coc-settings.json $HOME/.config/nvim/coc-settings.json 

	[ ! -f $HOME/.local/share/nvim/site/autoload/plug.vim ] && \
	    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

echo "setup oh-my-zsh"
check_install "zsh"
if [ ! -d $HOME/.oh-my-zsh ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	rm -rf $HOME/.zshrc
fi
ln -s $PWD/.zshrc $HOME/.zshrc

echo "setup tmux"
check_install "tmux"
ln -s $PWD/.tmux.conf $HOME/.tmux.conf

echo "setup git"
ln -s $PWD/.gitconfig $HOME/.gitconfig
ln -s $PWD/.gitignore $HOME/.gitignore

echo "setup yabai"
ln -s $PWD/.yabairc $HOME/.yabairc

echo "setup skhd"
ln -s $PWD/.skhdrc $HOME/.skhdrc

echo "setup git"
# config git ignore
ln -s $PWD/.gitignore $HOME/.gitignore
git config --global core.excludesfile ~/.gitignore

source .macos

echo "Done setup"

# $ npm install --global pure-prompt

