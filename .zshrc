# Powerline9k
source /usr/share/zsh-theme-powerlevel9k/powerlevel9k.zsh-theme

# Prompt customizations
POWERLEVEL9K_PROMPT_ON_NEWLINE=true   # place the prompt on the second line
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true  # ...and the rprompt as well
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true  # add a newline after each prompt
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status pyenv vcs root_indicator background_jobs time)
POWERLEVEL9K_PYENV_BACKGROUND='141'   # pyenv segment color
POWERLEVEL9K_DIR_HOME_BACKGROUND='006'     # dir segment color
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='006'     # dir segment color
POWERLEVEL9K_DIR_ETC_BACKGROUND='006'     # dir segment color
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='006'     # dir segment color

# Base16 Shell
BASE16_SHELL_SET_BACKGROUND=false
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
    eval "$("$BASE16_SHELL/profile_helper.sh")"

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
setopt INC_APPEND_HISTORY        # Add commands to history as they are typed, don't wait until shell exit
setopt HIST_REDUCE_BLANKS        # Remove extra blanks from each command line being added to history

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

# Globbing
setopt NO_CASE_GLOB                         # Case insensitive globbing
setopt EXTENDED_GLOB                        # Allow the powerful zsh globbing features, see link:
# http://www.refining-linux.org/archives/37/ZSH-Gem-2-Extended-globbing-and-expansion/
setopt NUMERIC_GLOB_SORT                    # Sort globs that expand to numbers numerically, not by letter (i.e. 01 2 03)

# Vim or Emacs?
bindkey -e
export KEYTIMEOUT=1
# ZSH keybindings
bindkey "\e[3~" delete-char          # [Delete] - delete forward
bindkey "^[[A" history-search-backward            # start typing + [Up-Arrow] - fuzzy find history forward
bindkey "^[[B" history-search-forward             # start typing + [Down-Arrow] - fuzzy find history backward
bindkey "\e\e" sudo-command-line                  # [Esc] [Esc] - insert "sudo" at beginning of line
zle -N sudo-command-line
sudo-command-line() {
[[ -z $BUFFER ]] && zle up-history
if [[ $BUFFER == sudo\ * ]]; then
    LBUFFER="${LBUFFER#sudo }"
else
    LBUFFER="sudo $LBUFFER"
fi
}

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# Some aliases
alias ls="ls -h --color='auto'"
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
alias ...="cd ..\.."
alias ....="cd ..\..\.."
alias /="cd /"

alias ncdu='ncdu --color dark'
alias info=pinfo
alias surf=surf-open

if [ "$DISPLAY" ]
then
    alias vi='gvim --remote-silent'
else
    alias vi='vim --remote-silent'
fi

# Setup grep to be a bit more nice
# check if 'x' grep argument available
grep-flag-available() {
    echo | grep $1 "" >/dev/null 2>&1
}

local GREP_OPTIONS=""

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

# export grep settings
alias grep="grep $GREP_OPTIONS"

# clean up
unfunction grep-flag-available

# Custom functions
###########################################################################

# Query commandlinefu.com
cmdfu() {
   curl "https://www.commandlinefu.com/commands/matching/$@/$(echo -n $@ | openssl base64)/plaintext";
}

# cdf - fuzzy cd from anywhere
# ex: cdf word1 word2 ... (even part of a file name)
# zsh autoload function
cdf() {
    local file

    file="$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1)"

    if [[ -n $file ]]
    then
        if [[ -d $file ]]
        then
            cd -- $file
        else
            cd -- ${file:h}
        fi
    fi
    unset file
}

flocate() {
    sel="$(locate -Ai -0 $@ | fzf --read0 -0)"
    if [[ "$DISPLAY" ]]
    then
        echo $sel | xclip -selection clipboard
        unset sel
    fi
}

# Colored MAN pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# Default editor
export EDITOR=vim

# Pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# ESP-IDF
export PATH="$HOME/esp/xtensa-esp32-elf/bin:$PATH"
export IDF_PATH=~/esp/esp-idf

# ESP8266
#export PATH="$HOME/esp/xtensa-lx106-elf/bin:$PATH"
#export IDF_PATH=~/esp/ESP8266_RTOS_SDK

# FZF
source $HOME/.fzf/zsh-interactive-cd.plugin.zsh
source $HOME/.fzf/completion.zsh
source $HOME/.fzf/key-bindings.zsh
#export FZF_COMPLETION_TRIGGER=''
#bindkey '^T' fzf-completion
#bindkey '^I' $fzf_default_completion

# Syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
