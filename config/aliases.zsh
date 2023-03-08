# ALIASES --------------------------------------------------------------------------------
command_exists() { command -v "$@" >/dev/null 2>&1 }
if command_exists exa; then
    alias ls="exa --icons --group-directories-first"
    alias ll="ls -lh --git"
    alias la="ls -a"
    alias lla="ll -a"
else
    alias ls="ls --color --group-directories-first"
    alias ll="ls -lh"
    alias la="ls -A"
    alias lla="ll -A"
fi
alias q="exit"
alias clr="clear"
alias ..="cd .."
