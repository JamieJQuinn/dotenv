#!/usr/bin/env bash

set -e

while read ignore_str; do
  echo "Testing $ignore_str"
  if wmctrl -l | grep "$ignore_str" -q; then
    echo "Skipping save."
    exit 0
  fi
done <~/.sshort_diary_ignores

notify_return=$(notify-send -t 10000 -A skip="Skip" "Taking screenshot in 15 seconds")

if [ "$notify_return" = "skip" ]; then
  echo "Skipping save."
  notify-send -t 500 "Skipping screenshot"
  exit 0
fi

sleep 5

scrot ~/Pictures/screenshot_diary/%Y-%m-%d-%T-screenshot.png
