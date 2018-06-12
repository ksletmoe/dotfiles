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

fi
