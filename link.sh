#!/bin/bash

# Vim/Nvim
mkdir -p ~/.vim
mkdir -p ~/.config
ln -s ~/.vim ~/.config/nvim
ln -sr .vimrc ~/.vimrc
ln -s ~/.vimrc ~/.config/nvim/init.vim

# Fish
mkdir -p ~/.config/fish
ln -s config.fish ~/.config/fish

# Bash
