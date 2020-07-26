#!/bin/sh

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

#xrandr --setprovideroutputsource 1 0
# xrandr --output DisplayPort-0 --primary
# xrandr --output DP-4 --primary
# xrandr --output HDMI-A-0 --rotate left
# xrandr --output DP-0 --rotate left
# xrandr --output HDMI-A-0 --left-of DisplayPort-0
# xrandr --output DP-0 --left-of DP-4
# xrandr --output HDMI-A-0 --pos 0x-150
# xrandr --output DP-0 --pos 0x-150

udiskie &
xbindkeys
xset r rate 250 30
numlockx &
xcape -t 200 -e 'Control_L=Escape;Shift_R=Caps_Lock'
unclutter --ignore-scrolling --timeout 2 --fork
xautolock -time 30 -locker slock &
xwallpaper --output DP-4 --center /home/ghetto/img/wallpaper
picom -b
lxpolkit &
dwm-status &
# nm-applet &
# blueman-applet &
exec dwm
