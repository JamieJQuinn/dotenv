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
if [ -e "~/.config/fish/config.fish" ]
then
  echo "Local fish config exists already"
else
  echo ". ~/.config/fish/config.fish.global" >> ~/.config/fish/config.fish
fi

#mkdir -p ~/.config/zathura
#ln -s $DIR/zathurarc ~/.config/zathura/zathurarc

mkdir -p ~/.config/kitty
ln -s $DIR/kitty.conf ~/.config/kitty/kitty.conf

#mkdir -p ~/.config/ranger
#ln -s $DIR/rc.conf ~/.config/ranger/rc.conf

mkdir -p ~/scripts
cp motd.sh ~/scripts
cp note ~/scripts
