#!/usr/bin/env fish

# Get working directory
set DIR (cd (dirname (status -f)); and pwd) 

# Vim/Nvim
mkdir -p ~/.vim
mkdir -p ~/.config
ln -s ~/.vim ~/.config/nvim
ln -s $DIR/.vimrc ~/.vimrc
ln -s ~/.vimrc ~/.config/nvim/init.vim

# Fish
mkdir -p ~/.config/fish
ln -s $DIR/config.fish.global ~/.config/fish/config.fish.global
if test -e ~/.config/fish/config.fish
  echo "Local fish config exists already"
else
  echo ". ~/.config/fish/config.fish.global" >> ~/.config/fish/config.fish
end
