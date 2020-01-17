#!/bin/sh

set -e

echo "Setup your Mac..."

if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew tap homebrew/bundle
brew bundle

if [ ! -d $HOME/.oh-my-zsh ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	rm -rf $HOME/.zshrc
fi

ln -s $HOME/Dotfiles/.zshrc $HOME/.zshrc
ln -s $HOME/Dotfiles/.slate $HOME/.slate

# config git ignore
ln -s $HOME/Dotfiles/.gitignore $HOME/.gitignore
git config --global core.excludesfile ~/.gitignore

source .macos

echo "Done setup"

# $ npm install --global pure-prompt

