#!/usr/bin/bash

set -e

if acpi | grep "Charging"; then exit 0; fi

battery_level=$(acpi | grep -oe '[0-9]*%' | grep -oe '[0-9]*')
trigger_pc=15

if (( "$battery_level" <= "$trigger_pc" )); then
  notify-send -w "Battery level: $battery_level" -u CRITICAL
fi
