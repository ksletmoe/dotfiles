# PATH shenanigans
export PATH="$PATH":~/bin

export PLATFORM=$(uname -s)

# aliases
alias ll="ls -al"

if [ "$PLATFORM" = "Darwin" ]; then
    alias lock="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
    alias zzz="pmset sleepnow"
    alias vim='mvim -v'
fi

if [ "$PLATFORM" = "Darwin" ]; then
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
          . $(brew --prefix)/etc/bash_completion
    fi
fi

if [ "$PLATFORM" = "Darwin" ]; then
    if [ -f `brew --prefix`/etc/bash_completion.d/git-completion.bash ]; then
      . `brew --prefix`/etc/bash_completion.d/git-completion.bash
    fi
fi

# to hold the local config I don't want to check into my dotfiles git repo (work stuff, mostly)
if [ -f "$HOME/.bashrc_local" ]; then
    . $HOME/.bashrc_local
fi

if [ -d "$HOME/.config/base16-shell" ]; then
    BASE16_SHELL=$HOME/.config/base16-shell/
    [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
fi

# set PS1
ColorOff="\[\033[0m\]"       # Text Reset

# Regular Colors
Black="\[\033[0;30m\]"        # Black
Red="\[\033[0;31m\]"          # Red
Green="\[\033[0;32m\]"        # Green
Yellow="\[\033[0;33m\]"       # Yellow
Blue="\[\033[0;34m\]"         # Blue
Purple="\[\033[0;35m\]"       # Purple
Cyan="\[\033[0;36m\]"         # Cyan
White="\[\033[0;37m\]"        # White

# Bold
BBlack="\[\033[1;30m\]"       # Black
BRed="\[\033[1;31m\]"         # Red
BGreen="\[\033[1;32m\]"       # Green
BYellow="\[\033[1;33m\]"      # Yellow
BBlue="\[\033[1;34m\]"        # Blue
BPurple="\[\033[1;35m\]"      # Purple
BCyan="\[\033[1;36m\]"        # Cyan
BWhite="\[\033[1;37m\]"       # White


# PS1
export VIRTUAL_ENV_DISABLE_PROMPT=1

function set_ps1() {
    local user_component="\u${Cyan}@${ColorOff}\h"
    [ -n "$RANGER_LEVEL" ] && user_component='🤠  '"$user_component"

    local virtualenv_component="\`if [[ -n \"\$VIRTUAL_ENV\" ]]; then echo \"${Cyan}───[venv:${ColorOff} \${VIRTUAL_ENV##*/}${Cyan}]${ColorOff}\"; fi\`"

    export PS1="${Cyan}┌─[${ColorOff}\`if [ \$? = 0 ]; then echo \"${Green}✔ ${ColorOff}\"; else echo \"${Red}✘ ${ColorOff}\"; fi\`${Cyan}]───[${ColorOff}\w${Cyan}]───[${ColorOff}${user_component}${Cyan}]${ColorOff}${virtualenv_component}\n${Cyan}└───➤ ${ColorOff} "
}

set_ps1

