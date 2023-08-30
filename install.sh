#!/usr/bin/env bash

# Get working directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Vim/Nvim
mkdir -p ~/.config
ln -s $DIR/nvim ~/.config/nvim

# Fish
mkdir -p ~/.config/fish
ln -s $DIR/global.fish ~/.config/fish/conf.d/global.fish

ln -s $DIR/scripts ~/scripts
