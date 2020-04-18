# Variables
export EDITOR=nvim
export TERMINAL=alacritty
export BROWSER=vimb-tabbed
export X_FILEMANAGER=spacefm
export CLI_FILEMANAGER=vifm
export HOST
export QT_QPA_PLATFORMTHEME=qt5ct
export PLAN9=/usr/local/plan9
export GOPATH=$HOME/Develop/goprojects
# Get java apps show up in dwm
export _JAVA_AWT_WM_NONREPARENTING=1
export RIPGREP_CONFIG_PATH=$HOME/.rgrc

export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH:$HOME/.nimble/bin:$HOME/.gem/ruby/2.6.0/bin:$PLAN9/bin:$GOPATH/bin"

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

# systemctl --user start tmux.service

# [[ ! $DISPLAY && $XDG_VTNR -eq 1 && $(id --group) -ne 0 ]] && exec startx
