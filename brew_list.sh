#!/usr/bin/env bash

function get_list() {
    local list=""
    for package in bash \
                   bash-completion \
                   tmux \
                   ranger \
                   vim \
                   git \
                   jq \
                   highlight \
                   tree \
                   cloc \
                   coreutils \
                   cask \
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
                   ruby
    do
        list="${list} ${package}"
    done

    echo "${list}"
}

get_list

