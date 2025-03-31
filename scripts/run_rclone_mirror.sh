#!/usr/bin/env bash

set -e

MODE=$1

if [ "$MODE" = "full" ]; then
  notify_return=$(notify-send -t 5000 -A skip="Skip" "Starting full backup in 5s")
  if [ "$notify_return" = "skip" ]; then
    echo "Skipping save."
    exit 0
  fi

  rclone sync $HOME encrypted_drumry_rd: -MPl --exclude-from=$HOME/mirror_exclude_list.txt --max-age 1h --fast-list --checkers 8 --exclude $HOME/.mozilla/ -v
elif [ "$MODE" = "partial" ]; then
  notify_return=$(notify-send -t 5000 -A skip="Skip" "Starting partial backup in 5s")
  if [ "$notify_return" = "skip" ]; then
    echo "Skipping save."
    exit 0
  fi

  rclone sync $HOME encrypted_drumry_rd: -MPl --exclude-from=$HOME/mirror_exclude_list.txt --fast-list --checkers 8 -v
else
  notify-send "Backup: Mode $MODE not recognised."
fi
