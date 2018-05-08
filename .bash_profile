if [ -f $HOME/.bashrc ]; then
    source $HOME/.bashrc
fi

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

export PIPENV_DEFAULT_PYTHON_VERSION=3.6
export PIPENV_SHELL_FANCY=1
export PIPENV_MAX_SUBPROCESS=64

