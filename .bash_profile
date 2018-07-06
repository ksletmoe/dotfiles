if [ -f $HOME/.bashrc ]; then
    source $HOME/.bashrc
fi

if [ -d "$HOME/.pyenv/bin" ]; then
    export PATH="$HOME/.pyenv/bin:$PATH"
fi

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
    eval "$(pyenv global 3.6.5)"
fi

export PIPENV_DEFAULT_PYTHON_VERSION=3.7
export PIPENV_SHELL_FANCY=1
export PIPENV_MAX_SUBPROCESS=64

export GOPATH="$HOME/development/go"
export GOBIN="$HOME/development/go/bin"

