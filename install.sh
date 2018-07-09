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

echo "Installing dotfiles..."

install_dotfile ".bashrc"  "${HOME}/.bashrc"
install_dotfile ".bash_profile" "${HOME}/.bash_profile"

install_dotfile ".vimrc" "${HOME}/.vimrc"
install_dotfile "en.utf-8.add" "${HOME}/.vim/spell/en.utf-8.add"
install_dotfile ".vimrc_global" "${HOME}/.vimrc_global"
install_dotfile ".ideavimrc" "${HOME}/.ideavimrc"


install_dotfile "rc.conf" "${HOME}/.config/ranger/rc.conf"
install_dotfile "scope.sh" "${HOME}/.config/ranger/scope.sh"

install_dotfile ".tmux.conf" "${HOME}/.tmux.conf"

# install_dotfile ".gitconfig" "${HOME}/.gitconfig"
install_dotfile ".gitignore" "${HOME}/.gitignore"

install_dotfile ".nethackrc" "${HOME}/.nethackrc"

echo "Doing misc. environment setup..."
# do any final environ setup

# set up a Go workspace at the path I exported in .bash_profile
source "${DOTFILES_DIR}/.bash_profile"
mkdir -p "$GOPATH/src/github.com"
mkdir -p "$GOPATH/bin"
mkdir -p "$GOPATH/pkg"
