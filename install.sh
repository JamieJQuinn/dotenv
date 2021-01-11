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

# Bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
rm ~/.bashrc
ln -s $DIR/.bashrc ~/.bashrc

mkdir -p ~/scripts
cp scripts/* ~/scripts
