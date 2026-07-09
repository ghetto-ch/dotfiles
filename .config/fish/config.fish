if status is-interactive
    if set -q SSH_TTY && not set -q __sourced_profile
        set -x __sourced_profile 1
        exec bash -c "\
					test -e /etc/profile && source /etc/profile
					test -e $HOME/.profile && source $HOME/.profile
					exec fish --login
			"
    end
    # Commands to run in interactive sessions can go here
    set -g fish_greeting
    set -x PYTHON_KEYRING_BACKEND keyring.backends.null.Keyring
    set -gx PARU_PAGER "aur-ai-review.sh"

    function fish_user_key_bindings
        # Execute this once per mode that emacs bindings should be used in
        fish_default_key_bindings -M insert

        # Then execute the vi-bindings so they take precedence when there's a conflict.
        # Without --no-erase fish_vi_key_bindings will default to
        # resetting all bindings.
        # The argument specifies the initial mode (insert, "default" or visual).
        fish_vi_key_bindings --no-erase insert

        bind --mode=insert ctrl-f fm
        bind --mode=insert ctrl-z "fg > /dev/null 2>&1"
    end

    # Emulates vim's cursor shape behavior
    # Set the normal and visual mode cursors to a block
    set fish_cursor_default block
    # Set the insert mode cursor to a line
    set fish_cursor_insert line
    # Set the replace mode cursors to an underscore
    set fish_cursor_replace_one underscore
    set fish_cursor_replace underscore
    # Set the external cursor to a line. The external cursor appears when a command is started.
    # The cursor shape takes the value of fish_cursor_default when fish_cursor_external is not specified.
    set fish_cursor_external line
    # The following variable can be used to configure cursor shape in
    # visual mode, but due to fish_cursor_default, is redundant here
    set fish_cursor_visual block

    set -gx XDG_CONFIG_HOME $HOME/.config
    set -gx EDITOR nvim
    set -gx MANPAGER 'nvim +Man!'
    set -gx CLI_FILEMANAGER yazi
    set -gx RIPGREP_CONFIG_PATH "$XDG_CONFIG_HOME/ripgrep/config"
    source "$XDG_CONFIG_HOME/fish/themes/kanagawa.fish"
    tv init fish | source
    zoxide init --cmd cd fish | source
end

# set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/ghetto/.ghcup/bin $PATH # ghcup-env
