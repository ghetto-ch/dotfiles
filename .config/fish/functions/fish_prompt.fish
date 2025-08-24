function fish_prompt
	if not set -q VIRTUAL_ENV_DISABLE_PROMPT
		set -g VIRTUAL_ENV_DISABLE_PROMPT true
	end

	set_color yellow
	printf '%s ' (prompt_pwd)
	set_color normal

	# Fish git prompt
	set __fish_git_prompt_showdirtystate 'yes'
	set __fish_git_prompt_showstashstate 'yes'
	set __fish_git_prompt_showuntrackedfiles 'yes'
	set __fish_git_prompt_showupstream 'yes'
	set __fish_git_prompt_color_branch yellow
	set __fish_git_prompt_color_upstream_ahead green
	set __fish_git_prompt_color_upstream_behind red

	# Status Chars
	set __fish_git_prompt_char_dirtystate '⚡'
	set __fish_git_prompt_char_stagedstate '→'
	set __fish_git_prompt_char_untrackedfiles '☡'
	set __fish_git_prompt_char_stashstate '↩'
	set __fish_git_prompt_char_upstream_ahead '+'
	set __fish_git_prompt_char_upstream_behind '-'

	function git_status
		set last_status $status
		printf '%s ' (__fish_git_prompt)
		set_color normal
	end

	set_color green
	git_status
	set_color normal

	# Line 2
	echo
	if test -n "$VIRTUAL_ENV"
		printf "(%s) " (set_color blue)(basename $VIRTUAL_ENV)(set_color normal)
	end
	printf '↪ '
	set_color normal

end
