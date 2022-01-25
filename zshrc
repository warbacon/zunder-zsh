HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

source "$HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$HOME/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

alias q="exit"
alias ls="exa --icons"
alias ll="ls -l"
alias la="ls -a"
alias clr="clear"

eval "$(starship init zsh)"
