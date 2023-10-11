# ALIASES ----------------------------------------------------------------------
alias grep="grep --color=auto"

if [[ -n $commands[exa] || -n $commands[eza] ]]; then
  [[ -n $commands[eza] && -z $commands[exa] ]] && alias exa="eza"
  if [[ "$TERM" != "linux" ]]; then
    alias ls="exa --icons --group-directories-first"
    alias ls="exa --icons --group-directories-first"
    alias ll="exa --icons --group-directories-first --git -lh"
    alias la="exa --icons --group-directories-first -a"
    alias lla="exa --icons --group-directories-first --git -lah"
    alias lt="exa --icons -T"
  else
    alias ls="exa --group-directories-first"
    alias ll="exa --group-directories-first --git -lh"
    alias la="exa --group-directories-first -a"
    alias lla="exa --group-directories-first --git -lah"
    alias lt="exa -T"
  fi
else
  alias ls="ls --color=auto --group-directories-first"
  alias ll="ls -lh"
  alias la="ls -A"
  alias lla="ls -lAh"
  [[ -n $commands[tree] ]] && alias lt="tree ."
fi
