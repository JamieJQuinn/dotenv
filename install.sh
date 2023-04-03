#!/usr/bin/env bash

# Get working directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Vim/Nvim
mkdir -p ~/.vim
mkdir -p ~/.config
ln -s ~/.vim ~/.config/nvim
ln -s $DIR/.vimrc ~/.vimrc
mkdir -p ~/.vim/spell
ln -s $DIR/spell_file ~/.vim/spell/en.utf-8.add
ln -s ~/.vimrc ~/.config/nvim/init.vim

# Fish
mkdir -p ~/.config/fish
ln -s $DIR/config.fish.global ~/.config/fish/config.fish.global
FILE=~/.config/fish/config.fish
if [[ -f $FILE ]]
then
  echo "Local fish config exists already"
else
  echo ". config.fish.global" >> ~/.config/fish/config.fish
fi

mkdir -p ~/scripts
cp scripts/* ~/scripts
