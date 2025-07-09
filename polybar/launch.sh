#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
#while pgrep -x polybar >/dev/null; do sleep 1; done

RESOLUTION=$(xrandr | rg "connected primary" | sd '.*connected primary (.*?) .*' '$1')
wired_interface="$(ip -o a | rg enp | sd '^.*(enp\d+s\d+(?:u\d+)*).*' '$1' | head -n 1)"
echo "wired_interface: '$wired_interface'"

wireless_interface="$(ip -o a | rg wlp | sd '^.*(wlp\d+s\d+(?:u\d+)*).*' '$1' | head -n 1)"
echo "wireless_interface: '$wireless_interface'"

if [ "$RESOLUTION" = "3840x2160+3840+0" ]; then
    echo "4K"
    width="100%"
    # height="65"
    height="40"
    # underline_size="5"
    underline_size="3"
    offset="0%"
    # font0="DejaVu Sans Mono:bold:size=14;1.5"
    font0="SF Pro:size=14:weight=200;1"
    font1="Terminess Nerd Font Mono:size=24;2"
    font2="M+ 1mn:bold:pixelsize=14;0; ; for Chinese/Japanese numerals (ttf-mplus)"
    # left="bspwm"
    left="i3"
    center="xwindow"
    right="playerctl-icon sep updates-pacman-aurhelper sep filesystem sep vpn-status sep wired-network sep date sep pulseaudio powermenu tray"
    window_title_size="100"
else
    echo "1080p"
    width="100%"
    height="30"
    underline_size="2"
    offset="0%"
    font0="Minecraft:size=12;1.5"
    font1="Terminess Nerd Font Mono:size=18;2"
    font2="M+ 1mn:bold:pixelsize=10;0; ; for Chinese/Japanese numerals (ttf-mplus)"
    # left="bspwm xwindow"
    left="i3 xwindow"
    center=" "
    right="playerctl-icon vpn-status wired-network wireless-network updates-pacman-aurhelper filesystem battery date pulseaudio powermenu tray"
    window_title_size="40"
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
INTERFACE=$wired_interface \
WIRELESS_INTERFACE=$wired_interface \
MONITOR=$primaryMonitor \
polybar mybar >>/tmp/polybar.log 2>&1 &

# Launch simplified bar on non-primary monitors
otherMonitors=$(xrandr | rg " connected " | rg -v "primary" | sd '^(.*?) .*' '$1')
for monitor in $otherMonitors
do
    echo $monitor
    center=""
    right="time powermenu"
    # font0="DejaVu Sans Mono:bold:size=14;1.5"
    font0="SF Pro:size=14:weight=200;1"
    font1="Terminess Nerd Font Mono:size=18;2"
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
    WINDOW_TITLE_SIZE=$window_title_size \
    polybar sidebar >>/tmp/polybar.log 2>&1 &
done

echo "Bars launched..."
