#!/usr/bin/env bash

for host in pi1 pi3; do
  echo $host | figlet
  ssh $host '~/print_info.sh'
done
