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
  str+="<span foreground='$bg' background='$fg' size='x-large'></span>"
fi

str+="<span background='$bg' size='x-large'>$icon$in</span>"

if [[ "$back" != "off" ]]; then
  str+="<span background='$bg' foreground='$fg' size='x-large'></span>"
fi

echo $str

