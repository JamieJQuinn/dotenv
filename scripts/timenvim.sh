#!/usr/bin/env bash

set -eu

nvim --startuptime startup.log -u ./new_vim_config/init.lua -c exit && tail -100 startup.log
