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

    # initial installation of homebrew
    if ! command -v brew &> /dev/null
    then
        curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
    fi

    brew install "${mac_packages[@]}"
    brew install "${cask_packages[@]}" --cask
  
    # install nerd fond hack
    brew tap homebrew/cask-fonts
    brew install --cask font-hack-nerd-font
fi

if [ -f "/etc/arch-release" ]; then

    # initial installation of yay
    if ! command -v yay &> /dev/null
    then
        pacman -S --needed git base-devel
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si
        cd ..
        rm -rf yay
    fi

    # install yay first
    yay -Syu "${arch_packages[@]}"
fi

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    # install tpm, tmux plugin manager
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if [ ! -d "$HOME/.rvm" ]; then
    gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
    curl -sSL https://get.rvm.io | bash -s stable
fi

if [ ! -d "$HOME/.nvm" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
fi

if [ ! -d "$HOME/.rustup" ]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
 
echo "done"
