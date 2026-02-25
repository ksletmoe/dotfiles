# so as not to be disturbed by Ctrl-S ctrl-Q in terminals:
[[ $- == *i* ]] && stty -ixon

# locale
export LANG=en_US.UTF-8

# load interactive shell config
if [ -f "$HOME/.bashrc" ]; then
  source "$HOME/.bashrc"
fi

# Lazy-load pyenv
pyenv() {
  eval "$(command pyenv init --path)"
  eval "$(command pyenv global $(command pyenv latest 3))"
  pyenv "$@"
}

# Lazy-load rbenv
rbenv() {
  eval "$(command rbenv init -)"
  rbenv "$@"
}

export PIPENV_DEFAULT_PYTHON_VERSION=3.12
export PIPENV_SHELL_FANCY=1
export PIPENV_MAX_SUBPROCESS=64

# path
case ":$PATH:" in
*:/usr/local/sbin:*) ;;
*) export PATH="/usr/local/sbin:$PATH" ;;
esac
