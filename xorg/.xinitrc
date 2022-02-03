#!/bin/sh
# for laptop:
# xrandr --output eDP-1-1 --primary --auto

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
sxhkd -r /tmp/output &
wal -R &
kitty &
xset +fp /home/leon/GitClones/tewi-font/out &
#picom --config ~/dotfiles/others/picom.conf &
picom --config ~/dotfiles/others/picom.conf --experimental-backends --backend glx &
#xrandr --output DVI-D-0 --mode 1920x1080 --scale 2x2 --left-of HDMI-A-0 --output HDMI-A-0 --primary --panning 3840x2160+3840+0 --output DisplayPort-0 --panning 3840x2160+7680+0
exec bspwm
