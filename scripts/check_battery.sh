#!/usr/bin/bash

set -e

battery_level=$(acpi | grep -oe '[0-9]*%' | grep -oe '[0-9]*')
trigger_pc=90

if (( "$battery_level" <= "$trigger_pc" )); then
  notify-send -w "Battery level: $battery_level" -u CRITICAL
fi
