#===============================================================================
#                                _                       _
#            _____   _ _ __   __| | ___ _ __     _______| |__
#           |_  / | | | '_ \ / _` |/ _ \ '__|___|_  / __| '_ \
#            / /| |_| | | | | (_| |  __/ | |_____/ /\__ \ | | |
#           /___|\__,_|_| |_|\__,_|\___|_|      /___|___/_| |_|
#
#===============================================================================

# ZINIT ------------------------------------------------------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[[ ! -d $ZINIT_HOME ]] && mkdir -p "$(dirname $ZINIT_HOME)"
[[ ! -d $ZINIT_HOME/.git ]] \
  && git clone --depth=1 https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

# Compiles zinit.zsh if it's newer than its compiled version. Then sources it.
[[ "$ZINIT_HOME/zinit.zsh.zwc" -nt "$ZINIT_HOME/zinit.zsh" ]] \
  || zcompile -R "$ZINIT_HOME/zinit.zsh"
source "$ZINIT_HOME/zinit.zsh"

# ZUNDER-PROMPT ----------------------------------------------------------------
zinit light-mode compile'./gitstatus/(install|*.zsh)' depth"1" for \
  Warbacon/zunder-prompt

# ZSH PLUGINS ------------------------------------------------------------------
zinit light-mode depth"1" nocd for \
  OMZP::command-not-found \
  OMZP::sudo \
  has"dircolors" \
  Warbacon/zsh-lscolors \
  as"completion" \
  zsh-users/zsh-completions \
  as"completion" has"docker" \
  https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

zinit wait lucid light-mode nocd depth"1" for \
  if'[[ ! -f /proc/sys/fs/binfmt_misc/WSLInterop ]]' \
  zdharma-continuum/fast-syntax-highlighting \
  if'[[ $TERM != "linux" ]]' \
  atinit"ZSH_AUTOSUGGEST_MANUAL_REBIND=1" atload"_zsh_autosuggest_start" \
  zsh-users/zsh-autosuggestions

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

# ALIASES ----------------------------------------------------------------------
alias grep="grep --color=auto"

if [[ -n $commands[exa] || -n $commands[eza] ]]; then
  [[ -n $commands[eza] && -z $commands[exa] ]] && alias exa="eza"
  if [[ "$TERM" != "linux" ]]; then
    alias ls="exa --icons --group-directories-first"
    alias ls="exa --icons --group-directories-first"
    alias ll="exa --icons --group-directories-first --git -lh"
    alias la="exa --icons --group-directories-first -a"
    alias lla="exa --icons --group-directories-first --git -lah"
    alias lt="exa --icons -T"
  else
    alias ls="exa --group-directories-first"
    alias ll="exa --group-directories-first --git -lh"
    alias la="exa --group-directories-first -a"
    alias lla="exa --group-directories-first --git -lah"
    alias lt="exa -T"
  fi
else
  if [[ "$(uname)" == "Darwin" ]]; then
    alias ls="ls -G"
  else
    alias ls="ls --color=auto --group-directories-first"
  fi
  alias ll="ls -lh"
  alias la="ls -A"
  alias lla="ls -lAh"
  [[ -n $commands[tree] ]] && alias lt="tree ."
fi

# OTHER ------------------------------------------------------------------------
setopt autocd # Change working directory without using cd

# Set word style to bash-like
autoload -U select-word-style
select-word-style bash

# Change window title
## It doesn't change it when shell_integration is enabled in kitty terminal
## because it has its own way of doing it.
if [[ -z $KITTY_SHELL_INTEGRATION && $TERM != "linux" ]]; then
  function set_win_title() {
    if [[ -z "$WT_SESSION" ]]; then
      printf "\033]0;%s@%s:%s\007" "${USER}" "${HOST%%.*}" "${PWD/#$HOME/~}"
    else
      printf "\033]0;%s\007" "${PWD/#$HOME/~}"
    fi
  }
  precmd_functions+=(set_win_title)
fi

# Disable background color on paste
zle_highlight+=(paste:none)

# LOAD KEY-BINDINGS ------------------------------------------------------------
zinit snippet "$ZDOTDIR/key-bindings.zsh"

# LOAD CUSTOM USER CONFIGURATION -----------------------------------------------
[[ -f "$ZDOTDIR/user-config.zsh" ]] \
  && zinit snippet "$ZDOTDIR/user-config.zsh"

# LOAD COMPINIT ----------------------------------------------------------------
autoload -Uz compinit && compinit
zinit cdreplay -q

[[ "$ZDOTDIR/.zcompdump.zwc" -nt "$ZDOTDIR/.zcompdump" ]] \
  || zcompile "$ZDOTDIR/.zcompdump"
