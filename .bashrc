# platform
PLATFORM="$(uname -s)"

# helpers
path_prepend() {
	local dir="$1"
	[ -n "$dir" ] || return 0
	[ -d "$dir" ] || return 0
	case ":$PATH:" in
		*":$dir:"*) ;;
		*) PATH="$dir:$PATH" ;;
	esac
}

# environment
export EDITOR="nvim"
export VIRTUAL_ENV_DISABLE_PROMPT=1
export PYENV_ROOT="$HOME/.pyenv"
export TMUX_TMPDIR="$HOME/.tmux/tmp"

# local overrides (not in dotfiles)
if [ -f "$HOME/.bashrc_local" ]; then
	. "$HOME/.bashrc_local"
fi

if [ "$PLATFORM" = "Darwin" ]; then
	alias lock="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
	alias zzz="pmset sleepnow"

	export PATH=/opt/homebrew/bin:$PATH

	if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
		. "$(brew --prefix)/etc/bash_completion"
	fi

	if [ -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ]; then
		. "$(brew --prefix)/etc/bash_completion.d/git-completion.bash"
	fi
fi

if [ -d "$HOME/.diff-so-fancy" ]; then
	export PATH="$HOME/.diff-so-fancy:$PATH"
fi

# pyenv
if command -v pyenv >/dev/null 2>&1; then
	eval "$(pyenv init - bash)"
fi

# prompt colors
ColorOff="\[\033[0m\]" # Text Reset
Black="\[\033[0;30m\]"  # Black
Red="\[\033[0;31m\]"    # Red
Green="\[\033[0;32m\]"  # Green
Yellow="\[\033[0;33m\]" # Yellow
Blue="\[\033[0;34m\]"   # Blue
Purple="\[\033[0;35m\]" # Purple
Cyan="\[\033[0;36m\]"   # Cyan
White="\[\033[0;37m\]"  # White
BBlack="\[\033[1;30m\]"  # Black
BRed="\[\033[1;31m\]"    # Red
BGreen="\[\033[1;32m\]"  # Green
BYellow="\[\033[1;33m\]" # Yellow
BBlue="\[\033[1;34m\]"   # Blue
BPurple="\[\033[1;35m\]" # Purple
BCyan="\[\033[1;36m\]"   # Cyan
BWhite="\[\033[1;37m\]"  # White

# prompt helpers
function __escape_slashes() {
	local input="$1"
	printf '%s\n' "$input" | sed -e 's/\//\\\//g'
}

# https://stackoverflow.com/a/44269076/906751
function __calc_ps1_path() {
	local path="$PWD"
	local home=$(__escape_slashes "$HOME")
	path=$(echo "$path" | sed -e "s/^$home/~/")
	local out=""
	local i=0
	for ((i = 0; i < ${#path}; i++)); do
		case "${path:i:1}" in
		\~) out+="${path:i:1}" ;;
		/)
			out+="${path:i:2}"
			continue
			;;
		*) continue ;;
		esac
	done
	__ps1_path="${out:0:-1}${path##*/}"
}

function __calc_git_branch_component() {
	git branch &>/dev/null
	if [ $? -eq 0 ]; then
		__ps1_git_branch_name=$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
	else
		__ps1_git_branch_name=""
	fi
}

if [[ -n "${PROMPT_COMMAND:-}" ]]; then
	PROMPT_COMMAND="__calc_ps1_path && __calc_git_branch_component; $PROMPT_COMMAND"
else
	PROMPT_COMMAND="__calc_ps1_path && __calc_git_branch_component"
fi

function set_ps1() {
	local user_component="\u${Cyan}@${ColorOff}\h"
	[ -n "$RANGER_LEVEL" ] && user_component='🤠  '"$user_component"

	local virtualenv_component="\`if [[ -n \"\$VIRTUAL_ENV\" ]]; then echo \"${Cyan}───[venv:${ColorOff} \${VIRTUAL_ENV##*/}${Cyan}]${ColorOff}\"; fi\`"
	local git_branch_component="\`if [[ -n \"\$__ps1_git_branch_name\" ]]; then echo \"${Cyan}───[${ColorOff}${BCyan}⎇ ${ColorOff} \${__ps1_git_branch_name}${Cyan}]${ColorOff}\"; fi\`"

	export PS1="${Cyan}┌─[${ColorOff}\`if [ \$? = 0 ]; then echo \"${Green}✔ ${ColorOff}\"; else echo \"${Red}✘ ${ColorOff}\"; fi\`${Cyan}]───[${ColorOff}\$__ps1_path${Cyan}]───[${ColorOff}${user_component}${Cyan}]${ColorOff}${git_branch_component}${virtualenv_component}\n${Cyan}└───➤ ${ColorOff} "
}

set_ps1

# utility functions
function swagger_editor() {
	if [ "$PLATFORM" = "Darwin" ]; then
		docker ps &>/dev/null
		if [[ $? != 0 ]]; then
			echo "Docker appears to not be running..."
			return 1
		fi

		docker ps | grep "swaggerapi/swagger-editor" &>/dev/null
		if [[ $? != 0 ]]; then
			echo "Starting swaggerapi/swagger-editor Docker container"
			docker run -d -p 8080:8080 swaggerapi/swagger-editor
		else
			echo "swaggerapi/swagger-editor Docker container already running"
		fi
		open http://localhost:8080
	else
		echo "Update this for non macOS, yo!"
	fi
}

# fzf display behavior
export FZF_CTRL_T_OPTS='--height=80% --reverse --info=inline --preview "bat --style=numbers --color=always --theme=base16-256 --line-range :500 {}"'
export FZF_ALT_C_OPTS='--preview "tree -C {} | head -200"'
export FZF_TMUX_OPTS='-p 80%,70%'

bind '"^[c":"fzf-cd-widget"'

# aliases
alias ll="ls -al"


bind '"^[c":"fzf-cd-widget"'

# aliases
alias ll="ls -al"

alias vim="nvim"

export PATH=$PATH:/Users/sletmoe/.toolbox/bin

if [ "$PLATFORM" = "Darwin" ]; then
	alias lock="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
	alias zzz="pmset sleepnow"

	export PATH=/opt/homebrew/bin:$PATH
	export PATH=/Users/sletmoe/.local/bin:$PATH

	# Lazy-load bash completion (saves ~0.27s)
	_load_completions() {
		BREW_PREFIX="/opt/homebrew"
		[ -f "$BREW_PREFIX/etc/bash_completion" ] && . "$BREW_PREFIX/etc/bash_completion"
		[ -f "$BREW_PREFIX/etc/bash_completion.d/git-completion.bash" ] && . "$BREW_PREFIX/etc/bash_completion.d/git-completion.bash"
		unset -f _load_completions
	}

	# Load on first tab completion
	complete -D -F _load_completions
fi

# Added by smithy-mcp
export PATH="/Users/sletmoe/.config/smithy-mcp/mcp-servers:$PATH"

# Added by AIM CLI
export PATH="/Users/sletmoe/.aim/mcp-servers:$PATH"
