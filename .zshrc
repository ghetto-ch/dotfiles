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
SAVEHIST=50000                   # Big history
HISTSIZE=50000                   # Big history
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

# Remove mode switching delay.
KEYTIMEOUT=5

# Change cursor shape for different vi modes.
function zle-keymap-select {
	if [[ ${KEYMAP} == vicmd ]] ||
		[[ $1 = 'block' ]]; then
				echo -ne '\e[1 q'

			elif [[ ${KEYMAP} == main ]] ||
				[[ ${KEYMAP} == viins ]] ||
				[[ ${KEYMAP} = '' ]] ||
				[[ $1 = 'beam' ]]; then
								echo -ne '\e[5 q'
	fi
}

zle -N zle-keymap-select
_fix_cursor() {
	echo -ne '\e[5 q'
}

precmd_functions+=(_fix_cursor)

# Some aliases
alias dh='dirs -v'
alias pd='popd'
alias ls='exa -g --group-directories-first'
# alias ls="ls -h --color='auto'"
alias ll='ls -l --git'
alias la='ll -a'
alias cl=clear
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

# alias surf=surf-open
alias vi=nvim

## Bulkrename cli utils
alias qmv='qmv -f do'

## buku shortcut
alias b='buku --suggest'

alias mcom='minicom -con'

alias lg=lazygit

## Setup grep to be a bit more nice
## check if 'x' grep argument available
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
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
	--multi --preview '(bat --color=always --style=numbers {} || tree -C {}) \
	2> /dev/null | head -200' --bind='ctrl-/:toggle-preview'"
export FZF_DEFAULT_COMMAND="fd $FD_OPTS"
export FZF_CTRL_T_COMMAND="fd $FD_OPTS --type f"
export FZF_CTRL_T_OPTS="--preview-window='right'"
export FZF_ALT_C_COMMAND="fd $FD_OPTS --type d"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200' --preview-window='right'"
export FZF_CTRL_R_OPTS="$FZF_CTRL_R_OPTS --reverse"

LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:';
export LS_COLORS

#compdef pio
_pio() {
	eval $(env COMMANDLINE="${words[1,$CURRENT]}" _PIO_COMPLETE=complete-zsh  pio)
}
if [[ "$(basename -- ${(%):-%x})" != "_pio" ]]; then
	compdef _pio pio
fi

## Powerlevel10k
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
## To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

## Syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
