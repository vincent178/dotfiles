#!/bin/bash

set -eof pipefail

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "install packages"

packages=('ranger' 'fzf' 'neovim' 'zsh' 'alacritty' 'golang' 'tmux' 'ranger' 'tig' 'rg' 'stow')
mac_packages=("${packages[@]}" 'gh')
linux_packages=("${packages[@]}" 'rofi' 'waybar')
cask_packages=('iterm2' 'raycask' 'wechat' 'visual-studio-code' 'keepingyouawake' 'amethyst')
  
if [ "$(uname)" = "Darwin" ]; then
    brew install "${mac_packages[@]}"
    brew install "${cask_packages[@]}" --cask
  
    # install nerd fond hack
    brew tap homebrew/cask-fonts
    brew install --cask font-hack-nerd-font
fi

if [ "$(uname)" = "Linux" ]; then
    # install yay first
    yay -Syu "${linux_packages[@]}"
fi

echo "done"
