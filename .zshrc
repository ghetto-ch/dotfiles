# Powerline9k
source /usr/share/zsh-theme-powerlevel9k/powerlevel9k.zsh-theme

# Prompt customizations
POWERLEVEL9K_PROMPT_ON_NEWLINE=true   # place the prompt on the second line
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true  # ...and the rprompt as well
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true  # add a newline after each prompt
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir pyenv vcs)
POWERLEVEL9K_PYENV_BACKGROUND='141'   # pyenv segment color
POWERLEVEL9K_DIR_HOME_BACKGROUND='006'     # dir segment color
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='006'     # dir segment color
POWERLEVEL9K_DIR_ETC_BACKGROUND='006'     # dir segment color
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='006'     # dir segment color


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

#   autoload -U compinit                                    # Autoload auto completion
#   compinit -i -d "${ZSH_COMPDUMP}"                        # Init auto completion; tell where to store autocomplete dump
   zstyle ':completion:*' menu select                      # Have the menu highlight as we cycle through options
   zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'     # Case-insensitive (uppercase from lowercase) completion
   zstyle ':completion:*' rehash true                      # Rehash completion automatically
   setopt COMPLETE_IN_WORD                                 # Allow completion from within a word/phrase
   setopt ALWAYS_TO_END                                    # When completing from the middle of a word, move cursor to end of word
#   setopt AUTO_MENU                                        # When using auto-complete, put the first option on the line immediately
   setopt COMPLETE_ALIASES                                 # Turn on completion for aliases as well
   setopt LIST_ROWS_FIRST                                  # Cycle through menus horizontally instead of vertically

# Globbing
   setopt NO_CASE_GLOB                         # Case insensitive globbing
   setopt EXTENDED_GLOB                        # Allow the powerful zsh globbing features, see link:
   # http://www.refining-linux.org/archives/37/ZSH-Gem-2-Extended-globbing-and-expansion/
   setopt NUMERIC_GLOB_SORT                    # Sort globs that expand to numbers numerically, not by letter (i.e. 01 2 03)

# ZSH keybindings
   bindkey "${terminfo[kdch1]}" delete-char          # [Delete] - delete forward
   bindkey "^[[A" history-search-backward            # start typing + [Up-Arrow] - fuzzy find history forward  
   bindkey "^[[B" history-search-forward             # start typing + [Down-Arrow] - fuzzy find history backward
   
# Some aliases
alias ls="ls -h --color='auto'"
alias la='ls -la'
alias clr=clear

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


# Pyenv
export PATH="/home/ghetto/.pyenv/bin:$PATH"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Syntax highlighting
   source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
