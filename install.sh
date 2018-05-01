#!/usr/bin/env bash

set -e

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


function archive_dotfile() {
    local dotfile_path="$1"
    mv "${dotfile_path}" "${dotfile_path}"'_bak'
}


function install_dotfile() {
    local dotfile_name="$1"
    local installation_path="$2"
    local installation_dir=$(dirname "${installation_path}")

    if [ -e "${installation_path}" ]; then
        if [ ! -L "${installation_path}" ]; then
            archive_dotfile "${installation_path}"
        fi
    else
        mkdir -p "${installation_dir}"
    fi

    ln -sf "${DOTFILES_DIR}/${dotfile_name}" "${installation_path}"
}


install_dotfile ".bashrc"  "${HOME}/.bashrc"
install_dotfile ".bash_profile" "${HOME}/.bash_profile"

install_dotfile ".vimrc" "${HOME}/.vimrc"

install_dotfile "rc.conf" "${HOME}/.config/ranger/rc.conf"

install_dotfile ".tmux.conf" "${HOME}/.tmux.conf"

install_dotfile ".gitconfig" "${HOME}/.gitconfig"

install_dotfile ".nethackrc" "${HOME}/.nethackrc"

