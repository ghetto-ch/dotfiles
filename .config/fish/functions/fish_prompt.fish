function fish_prompt
    if not set -q VIRTUAL_ENV_DISABLE_PROMPT
        set -g VIRTUAL_ENV_DISABLE_PROMPT true
    end

    set_color yellow
    printf '%s' (prompt_pwd)
    set_color normal

    function git_status
        set -g __fish_git_prompt_show_informative_status 1
        set -g __fish_git_prompt_showupstream informative
        set -g __fish_git_prompt_showdirtystate yes
        set -g __fish_git_prompt_showuntrackedfiles yes
        set -g __fish_git_prompt_color_branch brmagenta
        set -g __fish_git_prompt_color_stagedstate yellow
        set -g __fish_git_prompt_color_invalidstate red
        set -g __fish_git_prompt_color_cleanstate brgreen
        set -g __fish_git_prompt_color_dirtystate bryellow
        set -g __fish_git_prompt_color_untrackedfiles brcyan

        # Status Chars
        set -g __fish_git_prompt_char_stagedstate '●'
        set -g __fish_git_prompt_char_dirtystate '✎'
        set -g __fish_git_prompt_char_untrackedfiles '?'
        set -g __fish_git_prompt_char_stashstate '⚑'
        set -g __fish_git_prompt_char_conflictedstate '✖'
        set -g __fish_git_prompt_char_cleanstate '✔'
        set -g __fish_git_prompt_char_upstream_ahead '↑'
        set -g __fish_git_prompt_char_upstream_behind '↓'
        set -g __fish_git_prompt_char_upstream_diverged '↕'
        set -g __fish_git_prompt_char_stateseparator ' '

        printf '%s' (fish_git_prompt)
        set_color normal
    end

    # set_color green
    git_status
    # set_color normal

    # Line 2
    echo
    if set -q SSH_TTY
        set_color brblue
        printf '(ssh) '
        set_color normal
    end
    printf 'λ ' # ↪
    set_color normal
end
