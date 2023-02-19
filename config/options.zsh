# HISTORY --------------------------------------------------------------------------------
HISTFILE="$ZDOTDIR/.zsh_history"
HISTORY_IGNORE='(q|exit|clear|clr)'
HISTSIZE=10000
SAVEHIST=10000
setopt BANG_HIST              # Treat the '!' character specially during expansion.
setopt INC_APPEND_HISTORY     # Write to the history file immediately, not when the shell exits.
setopt HIST_EXPIRE_DUPS_FIRST # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS       # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS   # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS      # Do not display a previously found event.
setopt HIST_IGNORE_SPACE      # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS      # Do not write a duplicate event to the history file.
setopt HIST_VERIFY            # Do not execute immediately upon history expansion.
setopt HIST_BEEP              # Beep when accessing non-existent history.
setopt SHARE_HISTORY          # Share command history data

# COMPLETION STYLE -----------------------------------------------------------------------
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true

# OTHER ----------------------------------------------------------------------------------
function set_win_title(){
    echo -ne "\033]0;"$USER@$HOSTNAME:" ${PWD/$HOME/~}\007"
}
precmd_functions+=(set_win_title)
zle_highlight+=(paste:none)

setopt autocd                 # Change working directory without using cd

autoload -U select-word-style
select-word-style bash
