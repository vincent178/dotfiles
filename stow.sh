#!/bin/bash

stow zsh -t $HOME
stow tmux -t $HOME
stow scripts -t $HOME

# setup ssh config
mkdir -p .ssh
stow --target=$HOME/.ssh ssh

mkdir -p $HOME/.config

stow config -t $HOME/.config

