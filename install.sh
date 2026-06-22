#!/bin/bash

set -eof pipefail

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Pre-authenticate sudo so the Homebrew bootstrap and cask installs
# (which write to /opt/homebrew and /Applications) don't fail mid-script.
sudo -v

echo "install packages"

# libyaml: https://github.com/asdf-vm/asdf-ruby/issues/386
packages=('ranger' 'fzf' 'neovim' 'zsh' 'kitty' 'tmux' 'ranger' 'tig' 'ripgrep' 'stow' 'gh' 'mise' 'syncthing' 'antigen' 'pure' 'libyaml' 'uv')

if ! command -v brew &> /dev/null; then
    # initial installation of homebrew
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" "" > /dev/null
fi

brew install "${packages[@]}"

brew install --cask ghostty

brew install --cask claude-code

# install nerd fond hack
brew install --cask font-hack-nerd-font

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    # install tpm, tmux plugin manager
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo "done"
