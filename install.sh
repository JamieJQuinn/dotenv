#!/usr/bin/env bash

# Get working directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

CONFIG_DIR=~/.config
mkdir -p "$CONFIG_DIR"

for item in .config/nvim .config/kitty .config/i3 scripts .tmux.conf; do
  if [ ! -d "$item" ]; then
    ln -s "$DIR/$item" ~/"$item"
  else
    echo "~/$item already exists. Skipping."
  fi
done

# Fish
mkdir -p ~/.config/fish/conf.d
ln -s "$DIR/global.fish" ~/.config/fish/conf.d/global.fish
