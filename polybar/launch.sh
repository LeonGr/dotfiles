#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
#while pgrep -x polybar >/dev/null; do sleep 1; done

RESOLUTION=$(xrandr | rg "connected primary" | sd '.*connected primary (.*?) .*' '$1')

if [ "$RESOLUTION" = "3840x2160+0+0" ]; then
    echo "4K"
    width="98%"
    height="64"
    offset="1%"
    font0="DejaVu Sans Mono:bold:size=18;1.5"
    font1="TerminessTTF Nerd Font Mono:size=30;2"
    font2="M+ 1mn:bold:pixelsize=14;0; ; for Chinese/Japanese numerals (ttf-mplus)"
    left="bspwm"
    center="xwindow"
    right="updates-pacman-aurhelper sep network sep date sep pulseaudio"
    interface="enp6s0"
else
    echo "1080p"
    #width="96%"
    width="100%"
    #height="48"
    height="50"
    #offset="2%"
    offset="0%"
    font0="DejaVu Sans Mono:bold:size=12;1.5"
    font1="TerminessTTF Nerd Font Mono:size=18;2"
    font2="M+ 1mn:bold:pixelsize=10;0; ; for Chinese/Japanese numerals (ttf-mplus)"
    left="bspwm xwindow"
    center=" "
    right="updates-pacman-aurhelper sep filesystem sep battery sep date sep pulseaudio"
    interface="wlp2s0"
fi

# Launch bar
primaryMonitor=$(xrandr | rg "connected primary" | sd '^(.*?) .*' '$1')
echo "primary: $primaryMonitor"
echo "---" | tee -a /tmp/polybar.log
WIDTH=$width HEIGHT=$height OFFSET=$offset FONT0=$font0 FONT1=$font1 FONT2=$font2 LEFT=$left CENTER=$center RIGHT=$right INTERFACE=$interface MONITOR=$primaryMonitor polybar mybar >>/tmp/polybar.log 2>&1 &

echo "Bars launched..."
