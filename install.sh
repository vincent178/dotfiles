#!/bin/bash

set -eof pipefail

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "install packages"

packages=('ranger' 'fzf' 'neovim' 'zsh' 'alacritty' 'tmux' 'ranger' 'tig' 'ripgrep' 'stow' 'gh' 'node')

# packages for MacOS
mac_packages=("${packages[@]}" 'gh' 'antigen' 'go')
cask_packages=('iterm2' 'raycask' 'wechat' 'visual-studio-code' 'keepingyouawake' 'amethyst')

# packages for Arch Linux
arch_packages=("${packages[@]}" 'rofi' 'waybar' 'hyprcwd' 'antigen-git' 'golang')

if [ "$(uname)" = "Darwin" ]; then
    brew install "${mac_packages[@]}"
    brew install "${cask_packages[@]}" --cask
  
    # install nerd fond hack
    brew tap homebrew/cask-fonts
    brew install --cask font-hack-nerd-font
fi

if [ -f "/etc/arch-release" ]; then
    # install yay first
    yay -Syu "${arch_packages[@]}"
fi

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    # install tpm, tmux plugin manager
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
 
echo "done"
