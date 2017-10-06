[[ $- != *i* ]] && return # If not running interactively, don't do anything

.reload_interactive_config() {
	. "$HOME/.bashrc"
}

# Complete some commands that use...well, other commands
complete -cf sudo
complete -cf man

function __custom_ps1 () {
	local DEFAULT_COLOR="\[\033[00m\]"
	local RED_BOLD="\[\033[1;31m\]"
	local YELLOW_BOLD="\[\033[1;33m\]"
	local GREEN_BOLD="\[\033[1;32m\]"
	local BLUE_BOLD="\[\033[1;34m\]"

	__previous_result="$?";

	# git branch name
	local git_branch="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"
	local git_color=${RED_BOLD}
	local git_prompt=""
	if [[ $git_branch ]]; then
		git_prompt=" $git_color$git_branch";
	fi

	# Colored $ depending on error code
	local dollar=""
	case "$__previous_result" in
		0) dollar="${GREEN_BOLD}";;
		*) dollar="${YELLOW_BOLD}";;
	esac
	dollar="$dollar\$"

	local path="${BLUE_BOLD}\w"
	PS1="\n$path$git_prompt$dollar${DEFAULT_COLOR} "
}

PROMPT_DIRTRIM=3
PROMPT_COMMAND=__custom_ps1

.reload_interactive_extensions sh
.reload_interactive_extensions bash
