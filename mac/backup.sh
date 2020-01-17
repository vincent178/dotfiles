#!/usr/bin/env bash

set -e

safe_cp () {
	if [ -f $HOME/$1 ]; then
		cp $HOME/$1 .
	fi
}

safe_rm () {
	if [ -f $1 ]; then
		rm $1
	fi
}

echo "Backup your Mac..."

# backup homebrew bundle 
if test $(which brew); then
	echo "Backup Homebrew"
	brew tap homebrew/bundle

	# delete existing Brewfile
	safe_rm Brewfile

	brew bundle dump
fi

echo "Backup dotfiles"
safe_cp .gitignore
safe_cp .slate
safe_cp .zshrc 
safe_cp .tmux.conf 
safe_cp .vimrc 
safe_cp $HOME/.config/nvim/init.vim 

echo "Backup done"
