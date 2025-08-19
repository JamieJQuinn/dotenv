#!/usr/bin/env bash

notify_return=$(notify-send -t 5000 -A skip="Skip" "Starting backup in 5 seconds")

if [ "$notify_return" = "skip" ]; then
  echo "Skipping backup."
  exit 0
fi

# /usr/bin/borgmatic --verbosity -2 --syslog-verbosity 1
/usr/bin/borgmatic --verbosity 1 --syslog-verbosity 1
