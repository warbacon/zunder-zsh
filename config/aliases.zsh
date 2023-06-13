# ALIASES ----------------------------------------------------------------------
alias grep="grep --color=auto"
if command_exists exa; then
    if [[ -n $DISPLAY || $OS == "Android" ]]; then
        alias exa="exa --icons --group-directories-first"
    else
        alias exa="exa --group-directories-first"
    fi
    alias ls="exa"
    alias la="exa -a"
    alias ll="exa --git -lh"
    alias lla="exa --git -lha"
else
    alias ls="ls --color --group-directories-first"
    alias ll="ls -lh"
    alias la="ls -A"
    alias lla="ll -A"
fi

