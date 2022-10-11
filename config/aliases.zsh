# ALIASES --------------------------------------------------------------------------------
alias lg="lazygit"
if hash exa 2> /dev/null; then
    alias ls="exa --icons --group-directories-first --git"
    alias ll="ls -lh"
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
