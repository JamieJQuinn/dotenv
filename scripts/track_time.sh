#!/usr/bin/env bash

set -pe

NOTIFICATION_TIME_MS=5000
TIME_TRACKING_FILE="/home/jamie/notes/time.json"
TIMESTAMP=$(date +%FT%T%Z)

current_task=$(cat $TIME_TRACKING_FILE | jq .tasks[-1].task)

return=$(notify-send -t $NOTIFICATION_TIME_MS -A same=$current_task -A new="New task" "It's been 20 minutes, what are you doing?")

if [ "$return" = "same" ]; then
  echo same
elif [ "$return" = "new" ]; then
  echo new
else
  echo none
fi
