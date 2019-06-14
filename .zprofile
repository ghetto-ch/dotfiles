#if ! mount|grep ownCloud > /dev/null; then
#    mount /mnt/ownCloud
#fi

if ! mount|grep Data > /dev/null; then
    mount /mnt/Data
fi

if ! mount|grep Movies > /dev/null; then
    mount /mnt/Movies
fi

if ! mount|grep Series > /dev/null; then
    mount /mnt/Series
fi

if ! mount|grep Backups > /dev/null; then
    mount /mnt/Backups
fi

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.nimble/bin:$PATH"
export PLAN9=/usr/local/plan9
export PATH=$PATH:$PLAN9/bin

emulate sh -c 'source /etc/profile'
[[ ! $DISPLAY && $XDG_VTNR -eq 1 && $(id --group) -ne 0 ]] && exec startx
