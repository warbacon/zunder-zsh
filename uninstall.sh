#!/bin/bash

source ./lib/color.sh
source ./lib/constants.sh

# FUNCTIONS
remove_junk() {
    printf "${WARNING}Do you want to remove all the Zunder files? [y/N]: ${NORMAL}"
    read -r prompt
    if [[ $prompt = Y || $prompt = y  ]]; then
        mv "$ZDOTDIR/.zsh_history" "$HOME" 2> /dev/null
        rm -rf "$ZDOTDIR" "$HOME/.zshenv" "$HOME/.cache/p10k"* "$HOME/.cache/zinit" \
        "$HOME/.local/share/zinit"
    fi
}

# START
main() {
    remove_junk
    echo "------------"
    printf "${SUCCESS}All done.${NORMAL}\n"
}

main "$@"
