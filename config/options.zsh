# HISTORY ----------------------------------------------------------------------
HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000
setopt hist_expire_dups_first # Delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # Ignore duplicated commands history list
setopt hist_ignore_space      # Do not store commands prefixed with a space
setopt hist_verify            # Show command with history expansion to user before running it
setopt share_history          # Share history between all sessions.

# COMPLETION STYLE -------------------------------------------------------------
WORDCHARS=''
unsetopt menu_complete
unsetopt flowcontrol
setopt auto_menu
setopt complete_in_word
setopt always_to_end
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path $ZSH_CACHE_DIR
autoload -U +X bashcompinit && bashcompinit

# OTHER ------------------------------------------------------------------------
setopt autocd # Change working directory without using cd

# Change window title
## It doesn't change it when shell_integration is enabled in kitty terminal
## because it has its own way of doing it.
if [[ -z $KITTY_SHELL_INTEGRATION && $TERM != "linux" ]]; then
  function set_win_title() {
    printf "\033]0;%s@%s:%s\007" "${USER}" "${HOST%%.*}" "${PWD/#$HOME/~}"
  }
  precmd_functions+=(set_win_title)
fi

# Disable background color on paste
zle_highlight+=(paste:none)
