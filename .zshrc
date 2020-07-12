# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ZSH options
local ZSH_CONF=$HOME/.zsh           # Define the place I store all my zsh config stuff
local ZSH_CACHE=$ZSH_CONF/cache     # for storing files like history and zcompdump

declare -U path                     # prevent duplicate entries in path
setopt NO_BEEP                      # Disable beeps

# ZSH History
alias history='fc -fl 1'
HISTFILE=$ZSH_CACHE/history      # Keep our home directory neat by keeping the histfile somewhere else
SAVEHIST=10000                   # Big history
HISTSIZE=10000                   # Big history
setopt APPEND_HISTORY            # Allow multiple terminal sessions to all append to one zsh command history
setopt HIST_FIND_NO_DUPS         # When searching history don't display results already cycled through twice
setopt HIST_EXPIRE_DUPS_FIRST    # When duplicates are entered, get rid of the duplicates first when we hit $HISTSIZE
setopt HIST_IGNORE_SPACE         # Don't enter commands into history if they start with a space
setopt SHARE_HISTORY             # Shares history across multiple zsh sessions, in real time
setopt HIST_IGNORE_DUPS          # Do not write events to history that are duplicates of the immediately previous event
setopt HIST_IGNORE_ALL_DUPS      # If a new command line being added to the history list duplicates an older one, the older command is removed from the list (even if it is not the previous event).
setopt INC_APPEND_HISTORY        # Add commands to history as they are typed, don't wait until shell exit
setopt HIST_REDUCE_BLANKS        # Remove extra blanks from each command line being added to history
setopt autopushd pushdminus pushdsilent pushdtohome autocd
DIRSTACKSIZE=10

#the auto complete dump is a cache file where ZSH stores its auto complete data, for faster load times
local ZSH_COMPDUMP="$ZSH_CACHE/acdump-${SHORT_HOST}-${ZSH_VERSION}"  #where to store autocomplete data

autoload -U compinit                                    # Autoload auto completion
compinit -i -d "${ZSH_COMPDUMP}"                        # Init auto completion; tell where to store autocomplete dump
zstyle ':completion:*' menu select                      # Have the menu highlight as we cycle through options
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'     # Case-insensitive (uppercase from lowercase) completion
zstyle ':completion:*' rehash true                      # Rehash completion automatically
setopt COMPLETE_IN_WORD                                 # Allow completion from within a word/phrase
setopt ALWAYS_TO_END                                    # When completing from the middle of a word, move cursor to end of word
#   setopt AUTO_MENU                                        # When using auto-complete, put the first option on the line immediately
setopt COMPLETE_ALIASES                                 # Turn on completion for aliases as well
#setopt LIST_ROWS_FIRST                                  # Cycle through menus horizontally instead of vertically

# Autocompletions
eval "`pip completion --zsh`"
compctl -K _pip_completion pip3

# Globbing
setopt NO_CASE_GLOB                         # Case insensitive globbing
setopt EXTENDED_GLOB                        # Allow the powerful zsh globbing features
setopt NUMERIC_GLOB_SORT                    # Sort globs that expand to numbers numerically, not by letter (i.e. 01 2 03)
setopt RMSTARSILENT
## vim-mode
source ~/.zsh/zsh-vim-mode/zsh-vim-mode.plugin.zsh
export KEYTIMEOUT=20
# ZSH keybindings
bindkey "\e[3~" delete-char					      # [Delete] - delete forward
bindkey "^[[A" history-search-backward            # start typing + [Up-Arrow] - fuzzy find history forward
bindkey "^[[B" history-search-forward             # start typing + [Down-Arrow] - fuzzy find history backward

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# Some aliases
alias dh='dirs -v'
alias pd='popd'
alias ls='exa -g --group-directories-first'
# alias ls="ls -h --color='auto'"
alias la='ls -la'
alias ll='ls -l'
alias clr=clear
alias psyu="sudo pacman -Syu"
alias psearch="pacman -Ss"
# Pastebin
#alias pdc="curl -F 'f:1=<-' ix.io" # Create a pastebin
alias pbc="curl -F c=@- https://ptpb.pw/" # Create a pastebin
alias pbd="curl -X DELETE" # Delete a pastebin
alias pbu="curl -X PUT -F c=@-" # Update a pastebin

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias /="cd /"

#alias ncdu='ncdu --color dark'
alias info=pinfo

## alias surf=surf-open
alias vi=nvim

## Bulkrename cli utils
alias qmv='qmv -f do'

## buku shortcut
alias b='buku --suggest'

## Setup grep to be a bit more nice
## check if 'x' grep argument available
grep-flag-available() {
    echo | grep $1 "" >/dev/null 2>&1
}

local GREP_OPTIONS="-n"

# color grep results
if grep-flag-available --color=auto; then
   GREP_OPTIONS+=" --color=auto"
fi

# ignore VCS folders (if the necessary grep flags are available)
local VCS_FOLDERS="{.bzr,CVS,.git,.hg,.svn}"

if grep-flag-available --exclude-dir=.cvs; then
	GREP_OPTIONS+=" --exclude-dir=$VCS_FOLDERS"
elif grep-flag-available --exclude=.cvs; then
	GREP_OPTIONS+=" --exclude=$VCS_FOLDERS"
fi

## export grep settings
alias grep="grep $GREP_OPTIONS"

## clean up
unfunction grep-flag-available

export MANPAGER='nvim +Man!'

## Default editor
export VIMRUNTIME="/usr/share/nvim/runtime"

export FD_OPTS="--exclude .git -H"
export BAT_THEME="base16"

# FZF
source $HOME/.fzf/completion.zsh
source $HOME/.fzf/key-bindings.zsh
source $HOME/.fzf/base16/base16-default-dark.config
source $HOME/.fzf/fzf-tab/fzf-tab.plugin.zsh
# disable sort when completing options of any command
zstyle ':completion:complete:*:options' sort false
# query string
zstyle ':fzf-tab:*' query-string prefix input first
export FZF_COMPLETION_TRIGGER=','
export FZF_TMUX=0
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --multi --preview '(bat --color=always --style=numbers {} || tree -C {}) 2> /dev/null | head -200' --preview-window='hidden' --bind='alt-p:toggle-preview'"
export FZF_DEFAULT_COMMAND="fd $FD_OPTS"
export FZF_CTRL_T_COMMAND="fd $FD_OPTS --type f"
export FZF_CTRL_T_OPTS="--preview-window='right'"
export FZF_ALT_C_COMMAND="fd $FD_OPTS --type d"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200' --preview-window='right'"

## Powerlevel10k
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
## To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

## Syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
