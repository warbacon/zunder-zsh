skip_global_compinit=1       # for ubuntu based distributions

ZDOTDIR="$HOME/.config/zsh"  # sets the configuration location 

# Adds the ~/.local/bin directory to $PATH
typeset -U path
path+="$HOME/.local/bin"
export PATH
