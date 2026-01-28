#!/usr/bin/env bash

set -pie

reflector --protocol https --verbose --latest 5 --sort rate --country "United Kingdom" --download-timeout 60 --save /etc/pacman.d/mirrorlist
