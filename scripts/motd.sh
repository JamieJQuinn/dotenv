#!/bin/sh

upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
secs=$((${upSeconds}%60))
mins=$((${upSeconds}/60%60))
hours=$((${upSeconds}/3600%24))
days=$((${upSeconds}/86400))
#UPTIME=`printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs"`
#temp=$(sensors | grep "Package id 0" | awk '{print $4}')

################################################################################
##    BIG HOSTNAME
################################################################################

/usr/bin/env figlet "$(hostname)" | /usr/bin/env lolcat -f
echo

## Journal

echo "Last journal entry:" $(grep '^#' $NOTES_DIR/journal/$(date +%Y).md | tail -n1 | cut -d' ' -f2)
echo

## Notes conflict

printf "Current conflicts:\n"

fd sync-conflict $NOTES_DIR
echo

## Todos

printf "TODO:\n"

grep ASAP $NOTES_DIR/todo/todo.md
echo

##############################################################################
##    New hings
################################################################################

printf "New things:\n"
echo "- C-T in command to find a path with fzf"
echo "- A-C to change to any dir in home"
echo
