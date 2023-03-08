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
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _complete _expand _ignored _approximate
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' rehash true
setopt globdots

# OTHER ----------------------------------------------------------------------------------
# Change window title
function set_win_title(){
    echo -ne "\033]0;"$USER@$HOSTNAME:" ${PWD/$HOME/~}\007"
}
precmd_functions+=(set_win_title)

# Change working directory without using cd
setopt autocd

# Disable zsh-autocompletion on paste
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

 pastefinish() {
   zle -N self-insert $OLD_SELF_INSERT
 }
 zstyle :bracketed-paste-magic paste-init pasteinit
 zstyle :bracketed-paste-magic paste-finish pastefinish

# Disable background color on paste
zle_highlight+=(paste:none)

# Bash word style
autoload -U select-word-style
select-word-style bash
