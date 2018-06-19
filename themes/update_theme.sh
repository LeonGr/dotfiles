#!/bin/bash

{
(wal -i $1)

(sh ~/dotfiles/bspwm/bspwmrc)

(sh ~/dotfiles/dunst/dunst_script.sh)

(sh ~/dotfiles/vis/vis_script.sh)

(killall dunst && dunst)

} &> /dev/null

exit 1
