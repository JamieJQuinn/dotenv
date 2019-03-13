#!/usr/bin/env bash

# Get working directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Vim/Nvim
mkdir -p ~/.vim
mkdir -p ~/.config
ln -s ~/.vim ~/.config/nvim
ln -s $DIR/.vimrc ~/.vimrc
ln -s ~/.vimrc ~/.config/nvim/init.vim

# Fish
mkdir -p ~/.config/fish
ln -s $DIR/config.fish.global ~/.config/fish/config.fish.global
if [ -e "~/.config/fish/config.fish" ]
then
  echo "Local fish config exists already"
else
  echo ". ~/.config/fish/config.fish.global" >> ~/.config/fish/config.fish
fi
