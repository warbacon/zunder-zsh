# ALIASES ----------------------------------------------------------------------
alias grep="grep --color=auto"
if command_exists exa; then
    if [[ -n $DISPLAY || -n $TERMUX_VERSION || "$(uname)" == "Darwin" ]]; then
        alias exa="exa --icons --group-directories-first"
    else
        alias exa="exa --group-directories-first"
    fi
    alias ls="exa"
    alias ll="exa --git -lh"
    alias la="exa -a"
    alias lla="exa --git -lah"
else
    alias ls="ls --color=auto --group-directories-first"
    alias ll="ls -lh"
    alias la="ls -A"
    alias lla="ls -lAh"
fi

