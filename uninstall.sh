#!/bin/bash

source ./lib/color.sh
source ./lib/functions.sh
source ./lib/constants.sh

main() {
    printf "%bDo you want to remove all the Zunder files? [y/N]: %b" "$YELLOW$BOLD" \
        "$NORMAL"
    read -r prompt
    if [[ $prompt =~ (Y|y) ]]; then
        mv "$ZDOTDIR/.zsh_history" "$HOME" 2> /dev/null
        rm -rf "$ZDOTDIR" "$HOME/.zshenv" "$HOME/.cache/p10k"* "$HOME/.cache/zinit" \
               "$HOME/.local/share/zinit" "$HOME/.cache/starship" "$HOME/.cache/gitstatus"
    fi
    print_line
    print_success "All done."
}

main "$@"
