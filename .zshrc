export FPATH=~/.zsh.d/functions:$FPATH

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
setopt PROMPT_SUBST
setopt CORRECT_ALL
setopt CORRECT
setopt pushd_ignore_dups
setopt append_history     # Allow multiple terminal sessions to all append to one zsh command history
setopt inc_append_history # Add comamnds as they are typed, don't wait until shell exit
setopt hist_expire_dups_first # when trimming history, lose oldest duplicates first
setopt hist_ignore_dups # Do not write events to history that are duplicates of previous events
setopt hist_find_no_dups  # When searching history don't display results already cycled through twice
setopt hist_reduce_blanks # Remove extra blanks from each command line being added to history
setopt hist_verify # don't execute, just expand history

# ===== Completion 
setopt always_to_end  # When completing from the middle of a word, move the cursor to the end of the word    
setopt auto_menu      # show completion menu on successive tab press. needs unsetop menu_complete to work
setopt auto_name_dirs # any parameter that is set to the absolute name of a directory immediately becomes a name for that directory
setopt complete_in_word # Allow completion from within a word/phrase
unsetopt menu_complete # do not autoselect the first completion entry
setopt COMPLETE_ALIASES

unsetopt beep

zstyle :compinstall filename '/home/ghetto/.zshrc'
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '!'
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:git:*' formats '%F{yellow}[%b%F{red}%u%m%F{green}%c%F{yellow}]'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
     git status --porcelain | grep -m 1 '^??' &>/dev/null
  then
    hook_com[misc]='-'
  fi
}

autoload -Uz compinit promptinit vcs_info #manydots-magic
compinit
promptinit
#manydots-magic

precmd () {
    vcs_info
}

bindkey -e
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
bindkey "\e[3~" delete-char

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Prompt configuration

function virtualenv_info { 
 [ $VIRTUAL_ENV ] && echo "[${VIRTUAL_ENV##*/}${RESET}]"
}

setprompt () {
    # load some modules
    autoload -U zsh/terminfo # Used in the colour alias below
    # Use colorized output, necessary for prompts and completions.
    autoload -U colors && colors
    
    # make some aliases for the colours: (coud use normal escap.seq's too)
    for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
        eval PR_$color='%{$fg[${(L)color}]%}'
    done
    PR_NO_COLOR="%{$terminfo[sgr0]%}"

    # Check the UID
    if [[ $UID -ge 1000 ]]; then # normal user
        eval PR_USER='${PR_GREEN}%n${PR_NO_COLOR}'
        eval PR_USER_OP='${PR_GREEN}%#${PR_NO_COLOR}'
    elif [[ $UID -eq 0 ]]; then # root
        eval PR_USER='${PR_RED}%n${PR_NO_COLOR}'

        eval PR_USER_OP='${PR_RED}%#${PR_NO_COLOR}'
    fi      

    # Check if we are on SSH or not  --{FIXME}--  always goes to |no SSH|
    if [[ -z "$SSH_CLIENT"  ||  -z "$SSH2_CLIENT" ]]; then 
        eval PR_HOST='${PR_GREEN}%M${PR_NO_COLOR}' # no SSH
    else 
        eval PR_HOST='${PR_YELLOW}%M${PR_NO_COLOR}' #SSH
    fi

    NEWLINE=$'\n'
    # set the prompt
    PS1=$'@${PR_HOST} ${PR_BLUE}%d%f${NEWLINE}[${PR_USER}]${PR_USER_OP} '
    PS2=$'%_>'
    RPS1=$'${PR_MAGENTA}$(virtualenv_info)$vcs_info_msg_0_ ${PR_CYAN}[%*]'
    #RPROMPT='${PR_YELLOW}$vcs_info_msg_0_ ${PR_CYAN}[%T]'
}
setprompt

export PATH="/home/ghetto/.pyenv/bin:$PATH"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export EDITOR=nano
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

alias ls='ls --color=auto'
alias ll='ls -la'


