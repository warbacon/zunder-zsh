# ALIASES ----------------------------------------------------------------------
if command_exists exa; then
    alias exa="exa --icons --group-directories-first"
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

