#!/bin/sh

set -e

main() {
  printf "Do you want to remove all the Zunder files? [y/N]: "
  read -r prompt
  if [ "$prompt" = "y" ] || [ "$prompt" = "Y" ]; then
    rm -rf "$HOME/.zshenv" "$HOME/.zshrc"* \
      "$HOME/.cache/zinit" "$HOME/.local/share/zinit" \
      "$HOME/.cache/gitstatus" "$HOME/.cache/zsh/"
  fi
}

main "$@"
