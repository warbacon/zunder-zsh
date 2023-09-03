#!/bin/sh

ZDOTDIR="$HOME/.config/zsh"

set -e

main() {
  printf "Do you want to remove all the Zunder files? [y/N]: "
  read -r prompt
  if [ "$prompt" = "y" ] || [ "$prompt" = "Y" ]; then
    [ -f "$HOME/.zsh_history" ] && mv "$HOME/.zsh_history" "$HOME/.zsh_history.old"
    [ -f "$ZDOTDIR/.zsh_history" ] && mv "$ZDOTDIR/.zsh_history" "$HOME"
    rm -rf "$ZDOTDIR" "$HOME/.zshenv" "$HOME/.cache/p10k"* \
      "$HOME/.cache/zinit" "$HOME/.local/share/zinit" \
      "$HOME/.cache/starship" "$HOME/.cache/gitstatus"
  fi
}

main "$@"
