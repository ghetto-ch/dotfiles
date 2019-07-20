#if ! mount|grep ownCloud > /dev/null; then
#    mount /mnt/ownCloud
#fi

# if ! mount|grep Data > /dev/null; then
#     mount /mnt/Data
# fi

# if ! mount|grep Movies > /dev/null; then
#     mount /mnt/Movies
# fi

# if ! mount|grep Series > /dev/null; then
#     mount /mnt/Series
# fi

# if ! mount|grep Downloads > /dev/null; then
#     mount /mnt/Downloads
# fi

emulate sh -c 'source /etc/profile'
emulate sh -c 'source $HOME/.profile'

# export PATH="$HOME/.local/bin:$PATH"
# export PATH="$HOME/.nimble/bin:$PATH"
# export PLAN9=/usr/local/plan9
# export PATH=$PATH:$PLAN9/bin
# export PATH=$PATH:$HOME/.gem/ruby/2.6.0/bin
# export PATH="$HOME/.local/bin:$HOME/.nimble/bin:$PLAN9/bin:$HOME/.gem/ruby/2.6.0/bin:$PATH"

# [[ ! $DISPLAY && $XDG_VTNR -eq 1 && $(id --group) -ne 0 ]] && exec startx
