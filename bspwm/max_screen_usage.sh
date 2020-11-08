#!/bin/bash

window_gap=`bspc config window_gap`

if [ $window_gap -le 0 ]
then
    bspc config border_width        5
    bspc config window_gap          30
    bspc config top_padding         50
    bspc config left_padding        8
    bspc config right_padding       8
    bspc config bottom_padding      8
else
    bspc config window_gap          0
    bspc config border_width        1
    bspc config top_padding         0
    bspc config bottom_padding      0
    bspc config left_padding        0
    bspc config right_padding       0
fi


