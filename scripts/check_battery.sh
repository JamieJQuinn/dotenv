#!/usr/bin/bash

set -e

if acpi | grep "Charging"; then exit 0; fi

echo "On battery power"

battery_level=$(acpi | grep -oe '[0-9]*%' | grep -oe '[0-9]*')
trigger_pc=15

if [ "$battery_level" -le "$trigger_pc" ]; then
  echo "Low battery! Notifying user."
  notify-send -w "Battery level: $battery_level" -u CRITICAL
fi
