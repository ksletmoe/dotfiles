# so as not to be disturbed by Ctrl-S ctrl-Q in terminals:
[[ $- == *i* ]] && stty -ixon

# locale
export LANG=en_US.UTF-8

<<<<<<< HEAD
# load interactive shell config
if [ -f "$HOME/.bashrc" ]; then
	source "$HOME/.bashrc"
fi
||||||| parent of ffd31fd (Update my dotfiles)
if [ -f $HOME/.bashrc ]; then
	source $HOME/.bashrc
fi

if command -v pyenv 1>/dev/null 2>&1; then
	eval "$(pyenv init --path)"
	eval "$(pyenv global $(pyenv latest 3))"
fi
=======
if [ -f $HOME/.bashrc ]; then
	source $HOME/.bashrc
fi

# Lazy-load pyenv
pyenv() {
	eval "$(command pyenv init --path)"
	eval "$(command pyenv global $(command pyenv latest 3))"
	pyenv "$@"
}
>>>>>>> ffd31fd (Update my dotfiles)

<<<<<<< HEAD
# language tooling
if command -v rbenv 1>/dev/null 2>&1; then
	eval "$(rbenv init - bash)"
fi
||||||| parent of ffd31fd (Update my dotfiles)
if command -v rbenv 1>/dev/null 2>&1; then
	eval "$(rbenv init -)"
fi
=======
# Lazy-load rbenv
rbenv() {
	eval "$(command rbenv init -)"
	rbenv "$@"
}
>>>>>>> ffd31fd (Update my dotfiles)

<<<<<<< HEAD
# pipenv defaults
export PIPENV_DEFAULT_PYTHON_VERSION=3.11
||||||| parent of ffd31fd (Update my dotfiles)
export PIPENV_DEFAULT_PYTHON_VERSION=3.11
=======
export PIPENV_DEFAULT_PYTHON_VERSION=3.12
>>>>>>> ffd31fd (Update my dotfiles)
export PIPENV_SHELL_FANCY=1
export PIPENV_MAX_SUBPROCESS=64

# path
case ":$PATH:" in
	*:/usr/local/sbin:*) ;;
	*) export PATH="/usr/local/sbin:$PATH" ;;
esac
