#!/bin/bash

set -eof pipefail

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "install packages"

packages=('ranger' 'fzf' 'neovim' 'zsh' 'alacritty' 'golang' 'tmux' 'ranger' 'tig' 'ripgrep' 'stow' 'gh')

# packages for MacOS
mac_packages=("${packages[@]}" 'gh')
cask_packages=('iterm2' 'raycask' 'wechat' 'visual-studio-code' 'keepingyouawake' 'amethyst')

# packages for Arch Linux
linux_packages=("${packages[@]}" 'rofi' 'waybar' 'hyprcwd')

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

# install tpm, tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
 
echo "done"
