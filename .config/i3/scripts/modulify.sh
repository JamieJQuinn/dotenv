#!/usr/bin/env bash

set -e

in=$(cat)
fg=$1
bg=$2
icon=$3
front=$4
back=$5

str=""

if [[ "$front" != "off" ]]; then
  str+="<span foreground='$bg' background='$fg'></span>"
fi

str+="<span background='$bg'>$icon$in</span>"

if [[ "$back" != "off" ]]; then
  str+="<span background='$bg' foreground='$fg'></span>"
fi

echo $str

