#!/bin/bash

(wal -i $1)

(sh ~/dotfiles/bspwm/bspwmrc)

(sh ~/dotfiles/dunst/dunst_script.sh)

(killall dunst && dunst)

exit 1