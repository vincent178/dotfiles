#!/bin/bash

set -eof pipefail

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "install packages"

packages=('ranger' 'fzf' 'neovim' 'zsh' 'kitty' 'tmux' 'ranger' 'tig' 'ripgrep' 'stow' 'gh' 'mise' 'syncthing' 'antigen' 'pure')

# initial installation of homebrew
if ! command -v brew &> /dev/null
then
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
fi

brew install "${packages[@]}"

# install nerd fond hack
brew install --cask font-hack-nerd-font

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    # install tpm, tmux plugin manager
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo "done"
