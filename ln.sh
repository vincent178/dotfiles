#!/bin/bash

set -eof pipefail

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# link .config

configs=("alacritty" "bspwm" "sxhkd" "polybar" "git" "nvim" "yabai" "go" "rofi" "skhd")

for c in ${configs[@]};
do
  # link current folder to $HOME/.config
  ln -fs "$ROOT/.config/$c" "$HOME/.config/$c"
done
