#!/usr/bin/env bash

current_profile=$(powerprofilesctl get)

if [ "$current_profile" = 'power-saver' ]; then
  powerprofilesctl set performance
else
  powerprofilesctl set power-saver
fi

notify-send "Power profile: $(powerprofilesctl get)"

