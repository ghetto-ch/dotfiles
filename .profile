# Local paths
# export PATH="$HOME/.local/bin:$PATH"
# export PLAN9=/usr/local/plan9
# export PATH=$PATH:$PLAN9/bin
# export PATH=$PATH:$HOME/.gem/ruby/2.6.0/bin
# Variables
export EDITOR=nvim
export HOST
export QT_QPA_PLATFORMTHEME=qt5ct

export PATH="$HOME/.local/bin:$HOME/.nimble/bin:$PLAN9/bin:$HOME/.gem/ruby/2.6.0/bin:$PATH"

if ! mount|grep Data > /dev/null; then
    mount /mnt/Data
fi

if ! mount|grep Movies > /dev/null; then
    mount /mnt/Movies
fi

if ! mount|grep Series > /dev/null; then
    mount /mnt/Series
fi

if ! mount|grep Downloads > /dev/null; then
    mount /mnt/Downloads
fi
