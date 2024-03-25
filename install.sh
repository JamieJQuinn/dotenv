#!/usr/bin/env bash

# Get working directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

CONFIG_DIR=~/.config
mkdir -p "$CONFIG_DIR"

# Vim/Nvim
NVIM_CONFIG_DIR=$CONFIG_DIR/nvim
if [ ! -d "$NVIM_CONFIG_DIR" ]; then
  ln -s "$DIR/nvim" "$NVIM_CONFIG_DIR"
else
  echo "$NVIM_CONFIG_DIR already exists. Skipping."
fi

# Fish
mkdir -p ~/.config/fish/conf.d
ln -s "$DIR/global.fish" ~/.config/fish/conf.d/global.fish

# Scripts
SCRIPTS_DIR=~/scripts
if [ ! -d "$SCRIPTS_DIR" ]; then
  ln -s "$DIR/scripts" "$SCRIPTS_DIR"
else
  echo "$SCRIPTS_DIR already exists. Skipping."
fi

# Kitty
KITTY_CONFIG_DIR=$CONFIG_DIR/kitty
if [ ! -d "$KITTY_CONFIG_DIR" ]; then
  ln -s "$DIR/kitty" "$KITTY_CONFIG_DIR"
else
  echo "$KITTY_CONFIG_DIR already exists. Skipping."
fi

# Tmux
ln -s "$DIR/tmux.conf" ~/.tmux.conf
