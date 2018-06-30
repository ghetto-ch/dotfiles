mount /home/ghetto/ownCloud
mount /home/ghetto/Data
mount /home/ghetto/Movies
mount /home/ghetto/Series

emulate sh -c 'source /etc/profile'
[[ ! $DISPLAY && $XDG_VTNR -eq 1 && $(id --group) -ne 0 ]] && exec startx
