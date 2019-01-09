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

xrandr --output DP-4 --primary
xrandr --output DP-0 --rotate left
xrandr --output DP-0 --left-of DP-4
xrandr --output DP-4 --pos 1080x160

#twm &
#xclock -geometry 50x50-1+1 &
#xterm -geometry 80x50+494+51 &
#xterm -geometry 80x20+494-0 &
#exec xterm -geometry 80x66+0+0 -name login
udiskie &
clipmenud &
xbindkeys
setxkbmap -option ctrl:nocaps
setxkbmap -option compose:ralt
numlockx &
unclutter --ignore-scrolling --timeout 2 --fork
xautolock -time 15 -locker  slock &
~/.fehbg &
compton -b -d :0
dwm-status &
#exec i3
exec dwm
