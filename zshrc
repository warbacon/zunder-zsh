HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit

zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

alias q="exit"
alias ls="lsd"
alias ll="ls -l"
alias clr="clear"

source $HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

eval "$(starship init zsh)"
