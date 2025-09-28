#!/usr/bin/env bash

current_profile=$(powerprofilesctl get)

if [ "$current_profile" = 'power-saver' ]; then
  powerprofilesctl set performance
  echo "Setting performance"
else
  powerprofilesctl set power-saver
  echo "Setting power-saver"
fi

notify-send "Power profile: $(powerprofilesctl get)"
