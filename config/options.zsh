# HISTORY ----------------------------------------------------------------------
HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000
setopt INC_APPEND_HISTORY        # Share history between all sessions.
setopt HIST_IGNORE_SPACE         # Do not store commands prefixed with a space

# COMPLETION STYLE -------------------------------------------------------------
setopt GLOBDOTS 
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' rehash true

# OTHER ------------------------------------------------------------------------
setopt AUTOCD     # Change working directory without using cd

# Change window title
# It doesn't change it when shell_integration is enabled in kitty terminal
# because it has its own way of doing it
if [[ -z $KITTY_SHELL_INTEGRATION && $TERM != "linux" ]]; then
    function set_win_title(){
        printf "\033]0;%s@%s:%s\007" "${USER}" "${HOST%%.*}" "${PWD/#$HOME/~}"
    }
    precmd_functions+=(set_win_title)
fi

zle_highlight+=(paste:none)  # Disable background color on paste

autoload -Uz select-word-style && select-word-style bash  # Bash word style

