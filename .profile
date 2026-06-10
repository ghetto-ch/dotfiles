# Variables
export EDITOR=nvim
export TERMINAL=foot
export BROWSER=firefox
export X_FILEMANAGER=spacefm
export XDG_CONFIG_HOME=$HOME/.config
export GOPATH=$HOME/Develop/goprojects
export GHCUP_INSTALL_BASE_PREFIX=$HOME
export PATH="$PATH:$HOME/.local/bin:$GOPATH/bin:$HOME/.cabal/bin:$HOME/.ghcup/bin"

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

[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env" # ghcup-env
