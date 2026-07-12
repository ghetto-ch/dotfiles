# Variables
export EDITOR=nvim
export TERMINAL=wezterm
export BROWSER=firefox
export X_FILEMANAGER=thunar
export CLI_FILEMANAGER=yazi
export MANPAGER="nvim +Man!"
export XDG_CONFIG_HOME=$HOME/.config
export RIPGREP_CONFIG_PATH=$XDG_CONFIG_HOME/ripgrep/config
export GOPATH=$HOME/Develop/goprojects
export GHCUP_INSTALL_BASE_PREFIX=$HOME
export PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring
export PARU_PAGER=aur-ai-review
export PATH="$PATH:$HOME/.local/bin:$GOPATH/bin:$HOME/.cabal/bin:$HOME/.ghcup/bin"
export PROVA=prova

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
