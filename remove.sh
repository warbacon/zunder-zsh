#!/bin/env bash

source source/output.sh

# FUNCTIONS

restoreBackup() {
    printf "${WARNING}Do you want to restore your backup file (${CYAN}$HOME/.zshrc.bak${WARNING})? [y/N]: ${NORMAL}"
    read prompt
    if [[ $prompt = Y || $prompt = y  ]]; then
        mv --verbose "$HOME/.zshrc.bak" "$HOME/.zshrc"
    fi
}

removeJunk() {
    printf "${WARNING}Do you want to remove all the Zunder files? [y/N]: ${NORMAL}"
    read prompt
    if [[ $prompt = Y || $prompt = y  ]]; then
        rm -rf "$HOME/.p10k.zsh" "$HOME/.local/share/zinit" "$HOME/.zshrc"
    fi
}

# START

if [[ -f "$HOME/.p10k.zsh" || -d  "$HOME/.local/share/zinit" ]]; then
    removeJunk
fi

if [[ -f "$HOME/.zshrc.bak" ]]; then
    restoreBackup
fi

echo "--------------------------------------------"
printf "${SUCCESS}All done.${NORMAL}"
if [[ $TERM = "xterm-kitty" || $TERM = "alacritty" ]]; then
    printf " 🎉\n"
else
    printf "\n"
fi