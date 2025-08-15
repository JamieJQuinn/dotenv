#!/usr/bin/env bash

# Get working directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

CONFIG_DIR=~/.config
mkdir -p "$CONFIG_DIR"

for item in .config/nvim .config/kitty .config/fish .config/i3 .config/picom.conf .config/mpv .config/yazi scripts .tmux.conf .gitconfig; do
  if [ ! -e ~/"$item" ]; then
    ln -s "$DIR/$item" ~/"$item"
    echo "ln "$DIR/$item" => ~/$item"
  else
    echo "~/$item already exists. Skipping."
  fi
done

# Systemd
for item in $(ls $DIR/.config/systemd/user); do
  ln -s "$DIR/.config/systemd/user/$item" "$HOME/.config/systemd/user"
done

# Fish
# mkdir -p ~/.config/fish/conf.d
# ln -s "$DIR/global.fish" ~/.config/fish/conf.d/global.fish

# Kitty
LOCAL_CFG="$DIR/.config/kitty/kitty_$(hostname).conf"
touch $LOCAL_CFG
ln -s $LOCAL_CFG "$DIR/.config/kitty/kitty-local.conf"

# Fish
LOCAL_CFG="$DIR/.config/fish/config_$(hostname).fish"
touch $LOCAL_CFG
ln -s $LOCAL_CFG "$DIR/.config/fish/config.fish"
