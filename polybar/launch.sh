#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
#while pgrep -x polybar >/dev/null; do sleep 1; done

RESOLUTION=$(xrandr | rg "connected primary" | sd '.*connected primary (.*?) .*' '$1')

if [ "$RESOLUTION" = "3840x2160+3840+0" ]; then
    echo "4K"
    width="100%"
    # height="65"
    height="40"
    # underline_size="5"
    underline_size="3"
    offset="0%"
    font0="DejaVu Sans Mono:bold:size=14;1.5"
    font1="TerminessTTF Nerd Font Mono:size=24;2"
    font2="M+ 1mn:bold:pixelsize=14;0; ; for Chinese/Japanese numerals (ttf-mplus)"
    # left="bspwm"
    left="i3"
    center="xwindow"
    right="updates-pacman-aurhelper sep vpn-status sep network sep date sep pulseaudio powermenu"
    interface="enp7s0"
else
    echo "1080p"
    width="100%"
    height="30"
    underline_size="2"
    offset="0%"
    font0="DejaVu Sans Mono:bold:size=12;1.5"
    font1="TerminessTTF Nerd Font Mono:size=18;2"
    font2="M+ 1mn:bold:pixelsize=10;0; ; for Chinese/Japanese numerals (ttf-mplus)"
    # left="bspwm xwindow"
    left="i3 xwindow"
    center=" "
    right="updates-pacman-aurhelper sep filesystem sep battery sep date sep pulseaudio powermenu"
    interface="wlp2s0"
fi

primaryMonitor=$(xrandr | rg "connected primary" | sd '^(.*?) .*' '$1')

echo "primary: $primaryMonitor"
echo "---" | tee -a /tmp/polybar.log

# Launch bar
WIDTH=$width \
HEIGHT=$height \
UNDERLINE_SIZE=$underline_size \
OFFSET=$offset \
FONT0=$font0 \
FONT1=$font1 \
FONT2=$font2 \
LEFT=$left \
CENTER=$center \
RIGHT=$right \
INTERFACE=$interface \
MONITOR=$primaryMonitor \
polybar mybar >>/tmp/polybar.log 2>&1 &

# Launch simplified bar on non-primary monitors
otherMonitors=$(xrandr | rg " connected " | rg -v "primary" | sd '^(.*?) .*' '$1')
for monitor in $otherMonitors
do
    echo $monitor
    center=""
    right=""
    font0="DejaVu Sans Mono:bold:size=14;1.5"
    font1="TerminessTTF Nerd Font Mono:size=18;2"
    font2="M+ 1mn:bold:pixelsize=10;0; ; for Chinese/Japanese numerals (ttf-mplus)"
    height="30"
    underline_size="2"

    WIDTH=$width \
    HEIGHT=$height \
    UNDERLINE_SIZE=$underline_size \
    OFFSET=$offset \
    FONT0=$font0 \
    FONT1=$font1 \
    FONT2=$font2 \
    LEFT=$left \
    CENTER=$center \
    RIGHT=$right \
    INTERFACE=$interface \
    MONITOR=$monitor \
    polybar sidebar >>/tmp/polybar.log 2>&1 &
done

echo "Bars launched..."
