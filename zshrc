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

# KEY-BINDINGS
source ~/.config/zsh/key-bindings.zsh

# PLUGINS
source ~/.config/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source ~/.config/zsh/plugins/zsh-autopair/autopair.zsh
autopair-init

# STARSHIP PROMPT
eval "$(starship init zsh)"
