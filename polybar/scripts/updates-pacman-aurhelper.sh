#!/bin/bash
# based on: https://github.com/polybar/polybar-scripts/tree/master/polybar-scripts/updates-pacman-aurhelper

pacman_updates=$(pacman -Quq 2> /dev/null)
paru_updates=$(paru -Quq 2> /dev/null)

all_updates="${pacman_updates}\n${paru_updates}"

if [[ $all_updates = "\n" ]]; then
    updates=0
else
    updates=$(echo -e "$all_updates" | sort -u | wc -l)
fi

if [ "$updates" -gt 0 ]; then
    echo " $updates"
else
    echo " $updates"
fi
