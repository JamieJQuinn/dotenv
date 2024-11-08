#!/usr/bin/env bash

set -e

NEOVIM_VERSION=0.10.2

mkdir -p ~/.bin
wget "https://github.com/neovim/neovim/releases/download/v$NEOVIM_VERSION/nvim.appimage" -O ~/.bin/nvim.appimage.$NEOVIM_VERSION
chmod u+x ~/.bin/nvim.appimage.$NEOVIM_VERSION
ln -s ~/.bin/nvim.appimage.$NEOVIM_VERSION ~/.bin/nvim
