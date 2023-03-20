# HISTORY --------------------------------------------------------------------------------
HISTFILE="$ZDOTDIR/.zsh_history"
HISTORY_IGNORE='(q|exit|clear|clr)'
HISTSIZE=50000
SAVEHIST=10000
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

# COMPLETION STYLE -----------------------------------------------------------------------
setopt globdots
setopt menu_complete
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ":completion:*:default" list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' rehash true

# OTHER ----------------------------------------------------------------------------------
# Change window title
function set_win_title(){
    echo -ne "\033]0;"$USER@${HOST%%.*}:" ${PWD/$HOME/~}\007"
}
precmd_functions+=(set_win_title)

# Change working directory without using cd
setopt autocd

# Disable background color on paste
zle_highlight+=(paste:none)

# Bash word style
autoload -U select-word-style
select-word-style bash
