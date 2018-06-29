#!/usr/bin/env bash

if [ "$PLATFORM" = "Darwin" ]; then
    xcode-select --install

    brew install -y bash \
                    bash-completion \
                    tmux \
                    ranger \
                    git \
                    macvim \
                    ctags \
                    jq \
                    highlight \
                    tree \
                    cloc \
                    cmake \
                    go \
                    coreutils \
                    hexedit \
                    htop \
                    watch \
                    wget \
                    yamllint \
                    media-info \
                    proselint \
                    pyenv \
                    pipenv \
                    node \
                    ruby \
                    readline \
                    sqlite3 \
                    xz \
                    zlib

    brew tap homebrew/cask

    brew cask install iterm2 \
                      flycut \
                      caffeine \
                      bettertouchtool \
                      macdown \
                      docker \
                      virtualbox \
                      google-chrome \
                      cyberduck \
                      gimp \
                      vlc \
                      # spotify \
                      # pycharm-ce \
                      # slack
else
    sudo add-apt-repository ppa:pypa/ppa && sudo apt update

    sudo apt-get install -y make \
                            git \
                            htop \
                            tmux \
                            jq \
                            cmake \
                            cloc \
                            bash-completion \
                            tree \
                            hexedit  \
                            build-essential \
                            libssl-dev \
                            zlib1g-dev \
                            libbz2-dev \
                            libreadline-dev \
                            libsqlite3-dev \
                            wget \
                            curl \
                            llvm \
                            libncurses5-dev
                            libncursesw5-dev \
                            xz-utils \
                            tk-dev

    curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

    sudo apt-get install -y pipenv
fi


if [ ! -d "$HOME/.config/base16-shell" ]; then
    git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
fi
