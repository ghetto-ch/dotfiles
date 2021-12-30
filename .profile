# Variables
export EDITOR=nvim
export TERMINAL=alacritty
export BROWSER=brave
export X_FILEMANAGER=spacefm
export CLI_FILEMANAGER=vifm
export HOST
export XDG_CONFIG_HOME=$HOME/.config
export QT_QPA_PLATFORMTHEME=qt5ct
export PLAN9=/usr/local/plan9
export GOPATH=$HOME/Develop/goprojects
# Get java apps show up in dwm
export _JAVA_AWT_WM_NONREPARENTING=1
export RIPGREP_CONFIG_PATH=$HOME/.rgrc
export BW_SESSION="HvfyHep8tukRNuSTIJ42H0aZB7SlhwbEMTd8yI1MtyCLIod8mAM7nH2k7UjNpfs7jPdpFPMcNcQff2+YTwYPcQ=="

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

# [[ ! $DISPLAY && $XDG_VTNR -eq 1 && $(id --group) -ne 0 ]] && exec startx
