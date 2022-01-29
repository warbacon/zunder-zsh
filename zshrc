# HISTORY FILE
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# COMPLETIONS
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list '' '' 'm:{[:lower:]}={[:upper:]}'
zstyle ':completion:*' menu select
autoload -U select-word-style
select-word-style bash

# ALIASES
alias q="exit"
alias ls="exa --icons"
alias ll="ls -l"
alias la="ls -a"
alias clr="clear"

# PLUGINS
source "$HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$HOME/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

# STARSHIP PROMPT
eval "$(starship init zsh)"
