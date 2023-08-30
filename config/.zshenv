skip_global_compinit=1
ZDOTDIR="$HOME/.config/zsh"
if ! [[ "$PATH" =~ "$HOME/.local/bin:" ]]; then
  export PATH="$HOME/.local/bin:$PATH"
fi
