#export TERM=st-256color

# if [ "$TERM" != "linux" ]
# then


# 	# Prompt customizations
# 	POWERLEVEL9K_PROMPT_ON_NEWLINE=true   # place the prompt on the second line
# 	POWERLEVEL9K_RPROMPT_ON_NEWLINE=true  # ...and the rprompt as well
# 	POWERLEVEL9K_PROMPT_ADD_NEWLINE=true  # add a newline after each prompt
# 	POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir ssh)
# 	POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status pyenv vcs root_indicator background_jobs time)
# 	POWERLEVEL9K_PYENV_BACKGROUND='141'   # pyenv segment color
# 	POWERLEVEL9K_DIR_HOME_BACKGROUND='006'     # dir segment color
# 	POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='006'     # dir segment color
# 	POWERLEVEL9K_DIR_ETC_BACKGROUND='006'     # dir segment color
# 	POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='006'     # dir segment color

# else

# 	PROMPT='%n:%~%# '

# fi

# Base16 Shell
# BASE16_SHELL_SET_BACKGROUND=false
# BASE16_SHELL="$HOME/.config/base16-shell/"
# [ -n "$PS1" ] && \
#     [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
#     eval "$("$BASE16_SHELL/profile_helper.sh")"

# source $HOME/.fzf/base16/$BASE16_THEME.config

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
setopt autopushd pushdminus pushdsilent pushdtohome
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
eval "`pip completion --zsh`"
compctl -K _pip_completion pip3

# Globbing
setopt NO_CASE_GLOB                         # Case insensitive globbing
setopt EXTENDED_GLOB                        # Allow the powerful zsh globbing features, see link:
# http://www.refining-linux.org/archives/37-ZSH-Gem-2-Extended-globbing-and-expansion/
setopt NUMERIC_GLOB_SORT                    # Sort globs that expand to numbers numerically, not by letter (i.e. 01 2 03)
setopt RMSTARSILENT
# Vim or Emacs?
bindkey -v
source ~/.zsh/zsh-vim-mode/zsh-vim-mode.plugin.zsh
export KEYTIMEOUT=15
# ZSH keybindings
bindkey "\e[3~" delete-char					      # [Delete] - delete forward
bindkey "^[[A" history-search-backward            # start typing + [Up-Arrow] - fuzzy find history forward
bindkey "^[[B" history-search-forward             # start typing + [Down-Arrow] - fuzzy find history backward
# bindkey "\e\e" sudo-command-line                  # [Esc] [Esc] - insert "sudo" at beginning of line
# zle -N sudo-command-line
# sudo-command-line() {
# [[ -z $BUFFER ]] && zle up-history
# if [[ $BUFFER == sudo\ * ]]; then
#     LBUFFER="${LBUFFER#sudo }"
# else
#     LBUFFER="sudo $LBUFFER"
# fi
# }

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# Some aliases
alias dh='dirs -v'
alias pd='popd'
alias ls='exa'
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

alias ncdu='ncdu --color dark'
alias info=pinfo

# alias surf=surf-open
alias vi=nvim

# Bulkrename cli utils
alias qmv='qmv -f do'

# Setup grep to be a bit more nice
# check if 'x' grep argument available
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

# export grep settings
alias grep="grep $GREP_OPTIONS"

# clean up
unfunction grep-flag-available

# Custom functions
###########################################################################

# Query commandlinefu.com
# cmdfu() {
#    curl "https://www.commandlinefu.com/commands/matching/$@/$(echo -n $@ | openssl base64)/plaintext";
# }

# cdf - fuzzy cd from anywhere
# ex: cdf word1 word2 ... (even part of a file name)
# zsh autoload function
# fcd() {
#     local file

#     file="$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1)"

#     if [[ -n $file ]]
#     then
#         if [[ -d $file ]]
#         then
#             cd -- $file
#         else
#             cd -- ${file:h}
#         fi
#     fi
#     unset file
# }

# fl() {
# 	sel="$(locate -Ai -0 $@ | fzf --read0 -0)"
# 	if [[ "$DISPLAY" ]]
# 	then
# 		echo $sel | tr -d '\n' | xclip -selection clipboard
# 		unset sel
# 	fi
# }

# ec() {
# 	emacsclient -n -e "(if (> (length (frame-list)) 1) 't)" | grep t >/dev/null 2>/dev/null

# 	if [[ "$?" = "1" ]]
# 	then
# 		emacsclient -c -n -a "" "$@"
# 	else
# 		emacsclient -n -a "" "$@"
# 	fi
# }

# Colored MAN pages
# export LESS_TERMCAP_mb=$'\e[1;32m'
# export LESS_TERMCAP_md=$'\e[1;32m'
# export LESS_TERMCAP_me=$'\e[0m'
# export LESS_TERMCAP_se=$'\e[0m'
# export LESS_TERMCAP_so=$'\e[01;33m'
# export LESS_TERMCAP_ue=$'\e[0m'
# export LESS_TERMCAP_us=$'\e[1;4;31m'

# export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANPAGER='nvim +Man!'
# export MANWIDTH=999

# Default editor
export EDITOR=nvim

# Pyenv
# export PATH="$HOME/.pyenv/bin:$PATH"
# export PYENV_VIRTUALENV_DISABLE_PROMPT=1
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

# ESP-IDF
# export PATH="$HOME/esp/xtensa-esp32-elf/bin:$PATH"
# export IDF_PATH=~/esp/esp-idf

# ESP8266
#export PATH="$HOME/esp/xtensa-lx106-elf/bin:$PATH"
#export IDF_PATH=~/esp/ESP8266_RTOS_SDK

export FD_OPTS="--exclude .git -H"

# FZF
source $HOME/.fzf/zsh-interactive-cd.plugin.zsh
source $HOME/.fzf/completion.zsh
source $HOME/.fzf/key-bindings.zsh
export FZF_COMPLETION_TRIGGER=',,'
export FZF_TMUX=1
export FZF_DEFAULT_OPTS="--multi --preview '(bat --color=always --style=numbers {} || tree -C {}) 2> /dev/null | head -200' --preview-window='hidden' --bind='alt-p:toggle-preview'"
export FZF_DEFAULT_COMMAND="fd $FD_OPTS"
export FZF_CTRL_T_COMMAND="fd $FD_OPTS"
export FZF_CTRL_T_OPTS="--preview-window='right'"
export FZF_ALT_C_COMMAND="fd $FD_OPTS --type d"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200' --preview-window='right'"

#source $HOME/.zsh/z.sh
#source $HOME/.zsh/fz.sh
# eval "$(fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install)"
# eval $(thefuck --alias)
eval "$(fasd --init auto)"
#alias o='a -e xdg-open' # quick opening files with xdg-open

# fasd & fzf change directory - open best matched file using `fasd` if given argument, filter output of `fasd` using `fzf` else
# v() {
#     if [ "$DISPLAY" ]
#     then
#         cmd="nvim" #--remote-silent"
#     else
#         cmd="nvim" #--remote-silent"
#     fi

#     [ $# -gt 0 ] && fasd -f -B viminfo -e ${cmd} "$*" && return
#     local file
#     file="$(fasd -Rfl -B viminfo  "$1" | fzf -1 -0 --no-sort +m)" && vi "${file}" || return 1
# }

# fasd & fzf change directory - jump using `fasd` if given argument, filter output of `fasd` using `fzf` else
unalias z
z() {
    [ $# -gt 0 ] && fasd_cd -d "$*" && return
    local dir
    dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
}

o() {
    [ $# -gt 0 ] && fasd -a -e xdg-open "$*" && return
    local file
    file="$(fasd -Ral "$1" | fzf -1 -0 --no-sort +m)" && xdg-open "${file}" || return 1
}

# Powerline10k
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

