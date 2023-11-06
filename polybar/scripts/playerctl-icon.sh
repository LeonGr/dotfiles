#!/bin/bash

PLAYERS=$(playerctl -l 2>/dev/null)

if [[ $PLAYERS == "" ]]; then
    exit 0
elif [[ $PLAYERS == *"Sonixd"* ]]; then
    PLAYER="Sonixd"
elif [[ $PLAYERS == *"spotify"* ]]; then
    PLAYER="spotify"
else
    PLAYER="${PLAYERS[0]}"
fi

STATUS=$(playerctl -p "$PLAYER" status)
if [[ $STATUS = "Playing" ]]; then
    ICON=""
elif [[ $STATUS = "Paused" ]]; then
    ICON="󰝛"
fi

echo "$ICON"
