#!/bin/sh

set -e

echo "Setup your Mac..."

check_or_install () {
	if ! [ -x "$(command -v $1)" ]; then
		echo "not found $1, try to install it"
		if [ "$1" == "brew" ]; then
			/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
		else if [ "$1" == "zsh" ]; then
			sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
		else
			brew install $1
		fi
	fi
}

echo "install dotfiles"

echo "setup homebrew"
check_or_install "homebrew"
brew update
brew tap homebrew/bundle
brew bundle

echo "setup zshrc"
# ln -s $PWD/.zshrc $HOME/.zshrc

echo "setup slate"
# ln -s $HOME/Dotfiles/.slate $HOME/.slate

echo "setup oh-my-zsh"
if [ ! -d $HOME/.oh-my-zsh ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	rm -rf $HOME/.zshrc
fi

echo "setup git"
# config git ignore
ln -s $PWD/.gitignore $HOME/.gitignore
git config --global core.excludesfile ~/.gitignore

source .macos

echo "Done setup"

# $ npm install --global pure-prompt

