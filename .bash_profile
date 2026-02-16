# so as not to be disturbed by Ctrl-S ctrl-Q in terminals:
[[ $- == *i* ]] && stty -ixon

# locale
export LANG=en_US.UTF-8

# load interactive shell config
if [ -f "$HOME/.bashrc" ]; then
	source "$HOME/.bashrc"
fi

# language tooling
if command -v rbenv 1>/dev/null 2>&1; then
	eval "$(rbenv init - bash)"
fi

# pipenv defaults
export PIPENV_DEFAULT_PYTHON_VERSION=3.11
export PIPENV_SHELL_FANCY=1
export PIPENV_MAX_SUBPROCESS=64

# path
case ":$PATH:" in
	*:/usr/local/sbin:*) ;;
	*) export PATH="/usr/local/sbin:$PATH" ;;
esac
