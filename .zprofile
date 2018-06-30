
emulate sh -c 'source /etc/profile'
[[ ! $DISPLAY && $XDG_VTNR -eq 1 && $(id --group) -ne 0 ]] && exec startx
