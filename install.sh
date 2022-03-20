#!/bin/bash

set -eof pipefail

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "install packages"

packages=('ranger' 'fzf' 'neovim' 'zsh' 'alacritty' 'golang' 'tmux')
mac_packages=("${packages[@]}" 'yabai' 'skhd')
linux_packages=("${packages[@]}" 'sxhkd' 'bspwm' 'polybar' 'rofi')
  
if [ "$(uname)" = "Darwin" ]; then
  brew install "${mac_packages[@]}"
fi

if [ "$(uname)" = "Linux" ]; then
  yay -S "${linux_packages[@]}"
fi

echo "link files"

# link .config

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
