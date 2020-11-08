#!/bin/sh
xrandr --setprovideroutputsource modesetting NVIDIA-0
#xrandr --output DP-0 --auto --output eDP-1-1 --left-of DP-0 --auto
# hdmiMonitor=$(xrandr | grep "HDMI-[0-9]\sconnected " | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/")
# displayportMonitor=$(xrandr | grep "DP-[0-9]\sconnected " | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/")
# 
# xrandr --output $displayportMonitor --auto --primary --output $hdmiMonitor --auto --right-of $displayportMonitor

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

xset -b &
setxkbmap -option caps:escape &
xbindkeys &
sxhkd &
urxvt &
wal -R &
xset +fp /home/leon/GitClones/tewi-font/out &
picom --config ~/dotfiles/others/picom.conf &
exec bspwm
