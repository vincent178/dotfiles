#!/bin/bash

set -eof pipefail

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "install packages"

packages=('ranger' 'fzf' 'neovim' 'zsh' 'alacritty' 'golang' 'tmux' 'ranger' 'tig')
mac_packages=("${packages[@]}")
linux_packages=("${packages[@]}" 'sxhkd' 'bspwm' 'polybar' 'rofi')
cask_packages=('iterm2' 'raycask' 'wechat')
  
if [ "$(uname)" = "Darwin" ]; then
  brew install "${mac_packages[@]}"
  brew install "${cask_packages[@]}" --cask
fi

if [ "$(uname)" = "Linux" ]; then
  yay -S "${linux_packages[@]}"
fi

echo "link files"

# link .config

mkdir -p $HOME/.config

configs=("alacritty" "bspwm" "sxhkd" "polybar" "git" "nvim" "yabai" "go" "rofi" "skhd" "emacs")

for c in ${configs[@]};
do
  # link current folder to $HOME/.config
  ln -fs "$ROOT/.config/$c" "$HOME/.config"
done

# link .scripts

ln -fs "$ROOT/.scripts" $HOME

# link HOME dotfiles

dotfiles=('.Xmodmap' '.Xresources' '.zshrc' '.tmux.conf')

for d in "${dotfiles[@]}"; do
  ln -fs "$ROOT/$d" "$HOME"
done

echo "done"
