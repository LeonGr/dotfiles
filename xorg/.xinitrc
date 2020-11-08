#!/bin/sh
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --output DP-0 --auto --output eDP-1-1 --left-of DP-0 --auto

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
xrandr --output DisplayPort-0 --auto --output DVI-D-0 --auto --panning 3840x2160+3840+0 --scale 2x2 --right-of DisplayPort-0 &
wal -R &
picom --config /home/leon/dotfiles/others/compton.conf &
xset +fp /home/leon/GitClones/tewi-font/out &
exec bspwm
