# HISTORY --------------------------------------------------------------------------------
HISTFILE="$ZDOTDIR/.zsh_history"
HISTORY_IGNORE='(q|exit|clear|clr)'
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY

# COMPLETION STYLE -----------------------------------------------------------------------
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

# OTHER ----------------------------------------------------------------------------------
setopt autocd     # change working directory without using cd

autoload -U select-word-style
select-word-style bash
