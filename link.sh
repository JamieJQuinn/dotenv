#!/bin/bash

# Vim/Nvim
mkdir -p ~/.vim
mkdir -p ~/.config
ln -s ~/.vim ~/.config/nvim
ln -s .vimrc ~/.config/nvim/init.vim
ln -s .vimrc ~/.vimrc

# Fish
mkdir -p ~/.config/fish
ln -s config.fish ~/.config/fish

# Bash
