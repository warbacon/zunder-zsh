#!/bin/bash

source ./lib/color.sh

# FUNCTIONS

removeJunk() {
    printf "${WARNING}Do you want to remove all the Zunder files? [y/N]: ${NORMAL}"
    read prompt
    if [[ $prompt = Y || $prompt = y  ]]; then
        rm -rf "$HOME/.p10k.zsh" "$HOME/.local/share/zinit" "$HOME/.zshrc" "$HOME/.zcompinit"
    fi
}

restoreBackup() {
    printf "${WARNING}Do you want to restore your backup file (${CYAN}$HOME/.zshrc.bak${WARNING})? [y/N]: ${NORMAL}"
    read prompt
    if [[ $prompt = Y || $prompt = y  ]]; then
        mv --verbose "$HOME/.zshrc.bak" "$HOME/.zshrc"
    fi
}

# START

if [[ -f "$HOME/.p10k.zsh" || -d  "$HOME/.local/share/zinit" ]]; then
    removeJunk
fi

if [[ -f "$HOME/.zshrc.bak" ]]; then
    restoreBackup
fi

echo "------------"
printf "${SUCCESS}All done.${NORMAL}\n"
