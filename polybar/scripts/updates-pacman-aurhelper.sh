#!/bin/sh
# https://github.com/polybar/polybar-scripts/tree/master/polybar-scripts/updates-pacman-aurhelper

if ! updates_arch=$(checkupdates 2> /dev/null | wc -l ); then
    updates_arch=0
fi

if ! updates_aur=$(paru -Qum 2> /dev/null | wc -l); then
    updates_aur=0
fi

updates=$(("$updates_arch" + "$updates_aur"))

#notify-send " AUR/pacman" "$updates new updates"

if [ "$updates" -gt 0 ]; then
    echo " $updates"
else
    echo " $updates"
fi
