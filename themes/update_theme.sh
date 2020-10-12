#!/bin/bash

echo "[update_theme]"

echo "### wal ###"
if [ $# -eq 2 ]
then
    (wal -i $1 -a 95 --backend $2)
else
    (wal -i $1 -a 95)
fi

echo "### bspwmrc ###"
(sh ~/dotfiles/bspwm/bspwmrc) &

echo "### dunst ###"
(sh ~/dotfiles/dunst/dunst_script.sh)
(killall dunst && dunst)

echo "### vis ###"
(sh ~/dotfiles/vis/vis_script.sh)

echo "test"
exit 1
