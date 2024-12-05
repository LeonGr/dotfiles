#!/bin/bash

PLAYERS=$(playerctl -l)
echo "$PLAYERS"

if echo "$PLAYERS" | grep -w "Sonixd"; then
    echo "Sonixd running"
    PLAYER="Sonixd"
elif echo "$PLAYERS" | grep -w "spotify"; then
    echo "spotify running"
    PLAYER="spotify"
else
    PLAYER="${PLAYERS[0]}"
fi

echo "Player: $PLAYER"

# Check if we're currently focused on a window of the current player.
if xprop -id $(xdotool getwindowfocus) | rg 'WM_CLASS' | rg "$PLAYER"; then
    # Then this command will hide the current player
    i3-msg scratchpad show
else
    # Then this command will show the current player
    i3-msg [instance="(?i)$PLAYER"] focus
fi

# simpler version, but doesn't take player priority into account:
# i3-msg scratchpad show
