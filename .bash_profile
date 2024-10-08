#so as not to be disturbed by Ctrl-S ctrl-Q in terminals:
stty -ixon

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

if [ -f $HOME/.bashrc ]; then
	source $HOME/.bashrc
fi

if command -v pyenv 1>/dev/null 2>&1; then
	eval "$(pyenv init --path)"
	eval "$(pyenv global $(pyenv latest 3))"
fi

if command -v rbenv 1>/dev/null 2>&1; then
	eval "$(rbenv init -)"
fi

export PIPENV_DEFAULT_PYTHON_VERSION=3.11
export PIPENV_SHELL_FANCY=1
export PIPENV_MAX_SUBPROCESS=64
export PATH="/usr/local/sbin:$PATH"

# Setting PATH for Python 3.12
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.12/bin:${PATH}"
export PATH
