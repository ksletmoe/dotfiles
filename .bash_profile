#so as not to be disturbed by Ctrl-S ctrl-Q in terminals:
stty -ixon

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

if [ -f $HOME/.bashrc ]; then
    source $HOME/.bashrc
fi

if [ -d "$HOME/.pyenv/bin" ]; then
    export PATH="$HOME/.pyenv/bin:$PATH"
fi

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
    eval "$(pyenv global 3.7.7)"
fi

export PIPENV_DEFAULT_PYTHON_VERSION=3.7
export PIPENV_SHELL_FANCY=1
export PIPENV_MAX_SUBPROCESS=64
