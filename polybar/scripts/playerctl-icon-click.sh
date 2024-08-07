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

# Get song info
ARTIST=$(playerctl -p "$PLAYER" metadata xesam:albumArtist)
ALBUM=$(playerctl -p "$PLAYER" metadata xesam:album)
SONG=$(playerctl -p "$PLAYER" metadata xesam:title)

if [[ $ARTIST = "" ]]; then
    ARTIST=$(playerctl -p "$PLAYER" metadata xesam:artist)
    DETAILS=$ARTIST
else
    DETAILS="$ARTIST - $ALBUM"
fi

# Get album art URL
IMAGE_URL="$(playerctl -p "$PLAYER" metadata mpris:artUrl)"

if [[ $IMAGE_URL = "file://"* ]]; then
    IMAGE_PATH=$(echo "$IMAGE_URL" | sd 'file://' '')
    cp "$IMAGE_PATH" /tmp/album_icon.jpg
else
    # Download image
    wget -O /tmp/album_icon.jpg "$IMAGE_URL"
fi

STATUS=$(playerctl -p "$PLAYER" status)
if [[ $STATUS = "Playing" ]]; then
    STATUS="󰐊"
else
    STATUS="󰏤"
fi

if [[ $(playerctl -p "$PLAYER" shuffle) = "On" ]]; then
    STATUS="${STATUS} 󰒟"
fi

if [[ $(playerctl -p "$PLAYER" loop) = "Playlist" ]]; then
    STATUS="${STATUS} 󱞲"
elif [[ $(playerctl -p "$PLAYER" loop) = "Track" ]]; then
    STATUS="${STATUS} 󱦙"
fi

# Show notification
/usr/bin/notify-send -u low "$SONG / $STATUS" "$DETAILS" --icon /tmp/album_icon.jpg
