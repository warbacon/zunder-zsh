#!/bin/sh

set -e

main() {
    printf "Do you want to remove all the zunder-zsh-related files? [y/N]: "
    read -r prompt
    if [ "$prompt" = "y" ] || [ "$prompt" = "Y" ]; then
        rm -rf "$HOME/.zshenv" "$HOME/.zshrc" "$HOME/.local/share/zap" \
            "$HOME/.cache/zsh"
    fi
}

main "$@"
