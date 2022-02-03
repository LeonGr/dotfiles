#!/bin/sh
xrandr --output eDP-1-1 --primary --auto

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

# Env variables
#export QT_QPA_PLATFORMTHEME="qt5ct"
#export LIBVA_DRIVER_NAME="radeonsi"
#export VDPAU_DRIVER="radeonsi"

xset -b &
caps2esc &
xbindkeys &
sxhkd &
wal -R &
urxvt &
xset +fp /home/leon/GitClones/tewi-font/out &
#picom --config ~/dotfiles/others/picom.conf &
picom --config ~/dotfiles/others/picom.conf --experimental-backends --backend glx &
exec bspwm
