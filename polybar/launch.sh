#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
#while pgrep -x polybar >/dev/null; do sleep 1; done

RESOLUTION=$(xrandr | grep -E "connected primary" | sed -e "s/.*connected primary//" | sed -e "s/\s(.*//" | sed -e "s/\s//")

if [ "$RESOLUTION" = "3840x2160+0+0" ]; then
    echo "4K"
    width="98%"
    height="64"
    offset="1%"
    font0="Inconsolata:bold:size=18;1.5"
    font1="TerminessTTF Nerd Font Mono:size=30;2"
    font2="M+ 1mn:bold:pixelsize=14;0; ; for Chinese/Japanese numerals (ttf-mplus)"
    left="bspwm"
    center="xwindow"
    right="updates-pacman-aurhelper sep network sep date sep pulseaudio"
    interface="enp6s0"
else
    echo "1080p"
    width="96%"
    height="48"
    offset="2%"
    font0="Inconsolata:bold:size=12;1.5"
    font1="TerminessTTF Nerd Font Mono:size=18;2"
    font2="M+ 1mn:bold:pixelsize=10;0; ; for Chinese/Japanese numerals (ttf-mplus)"
    left="bspwm xwindow"
    center=""
    right="updates-pacman-aurhelper sep filesystem sep battery sep date sep pulseaudio"
    interface="wlp2s0"
fi

# Launch bar
echo "---" | tee -a /tmp/polybar.log
primaryMonitor=$(xrandr | grep -E " connected primary" | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/")
WIDTH=$width HEIGHT=$height OFFSET=$offset FONT0=$font0 FONT1=$font1 FONT2=$font2 LEFT=$left CENTER=$center RIGHT=$right INTERFACE=$interface MONITOR=$primaryMonitor polybar mybar >>/tmp/polybar.log 2>&1 &


echo "Bars launched..."
