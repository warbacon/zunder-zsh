#===============================================================================
#                                _                       _
#            _____   _ _ __   __| | ___ _ __     _______| |__
#           |_  / | | | '_ \ / _` |/ _ \ '__|___|_  / __| '_ \
#            / /| |_| | | | | (_| |  __/ | |_____/ /\__ \ | | |
#           /___|\__,_|_| |_|\__,_|\___|_|      /___|___/_| |_|
#
#===============================================================================

# ZUNDER-ZSH INITIAL CONFIG ----------------------------------------------------
# Directory where before.zsh and after.zsh are located
ZUNDER_ZSH_DIR="$HOME/.config/zunder-zsh"

# Create .cache directory if it doesn't exist
[ ! -d "$HOME/.cache/zsh" ] && mkdir -p "$HOME/.cache/zsh"

# Disable syntax highlightling in WSL
[ -f /proc/sys/fs/binfmt_misc/WSLInterop ] && DISABLE_SYNTAX_HIGHLIGHTING=true

# Disable autosuggestions and exa in Linux tty
if [[ "$TERM" == "linux" ]]; then
  DISABLE_AUTOSUGGESTIONS=true
  DISABLE_EXA=true
fi

# ZINIT ------------------------------------------------------------------------
# Changes the zcompdump directory
declare -A ZINIT
ZINIT[ZCOMPDUMP_PATH]="$HOME/.cache/zsh/.zcompdump"   

# Zinit initialization
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d "$ZINIT_HOME" ] && mkdir -p "$(dirname "$ZINIT_HOME")"
[ ! -d "$ZINIT_HOME"/.git ] \
  && git clone https://github.com/zdharma-continuum/zinit.git \
    "$ZINIT_HOME"

# Compiles zinit.zsh if it's newer than its compiled version. Then sources it.
[ "$ZINIT_HOME/zinit.zsh.zwc" -nt "$ZINIT_HOME/zinit.zsh" ] \
  || zcompile -R "$ZINIT_HOME/zinit.zsh"
source "$ZINIT_HOME/zinit.zsh"

# BEFORE CONFIG ----------------------------------------------------------------
[ -f "$ZUNDER_ZSH_DIR/before.zsh" ] && source "$ZUNDER_ZSH_DIR/before.zsh"

# ZSH PLUGINS ------------------------------------------------------------------
# Zunder-prompt
zinit light-mode depth"1" if'[[ $DISABLE_ZUNDER_PROMPT != true ]]' for \
  make"zwc" romkatv/gitstatus \
  warbacon/zunder-prompt

# Oh My Zsh plugins
zinit light-mode for \
    OMZP::command-not-found \
    OMZL::key-bindings.zsh

# Additional completions
zinit light-mode for \
  blockf depth"1" \
    zsh-users/zsh-completions \
  as"completion" has"docker" \
    https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker \
  as"completion" has"conda" \
    https://github.com/conda-incubator/conda-zsh-completion/blob/master/_conda

# Fast-syntax-highlighting and zsh-autosuggestions
zinit wait lucid light-mode depth"1" for \
  if'[[ $DISABLE_SYNTAX_HIGHLIGHTING != true ]]' \
    zdharma-continuum/fast-syntax-highlighting \
  if'[[ $DISABLE_AUTOSUGGESTIONS != true ]]' \
  atinit"ZSH_AUTOSUGGEST_MANUAL_REBIND=1" atload"_zsh_autosuggest_start" nocd \
    zsh-users/zsh-autosuggestions
 
# ADDITIONAL KEY-BINDINGS ------------------------------------------------------
# [Alt-RightArrow] - move forward one word
bindkey '^[[1;3C' forward-word
# [Alt-LeftArrow] - move backward one word
bindkey '^[[1;3D' backward-word

# Set word style to bash-like
autoload -U select-word-style && select-word-style bash

# HISTORY ----------------------------------------------------------------------
HISTFILE="$HOME/.zsh_history"   # Location of the history file
HISTSIZE=50000                  # Maximum number of commands in the history
SAVEHIST=10000                  # Number of commands to save between sessions
setopt share_history            # Share history between sessions

# COMPLETION STYLE -------------------------------------------------------------
# Enable the completion menu
zstyle ':completion:*' menu select

# Match completion menu colors with the LS_COLORS variable
[[ -n $LS_COLORS ]] && zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Ignore cases if there are no uppercase letters
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

# Attempt to find new commands to complete
zstyle ':completion:*' rehash true

# ALIASES ----------------------------------------------------------------------
# Enable colors in grep
alias grep="grep --color=auto"

# List files and directories aliases
if [[ (-n $commands[exa] || -n $commands[eza]) && $DISABLE_EXA != true ]]; then
  [[ -n $commands[eza] && -z $commands[exa] ]] && alias exa="eza"
  alias ls="exa --icons --group-directories-first"
  alias ls="exa --icons --group-directories-first"
  alias ll="exa --icons --group-directories-first --git -l"
  alias la="exa --icons --group-directories-first -a"
  alias lla="exa --icons --group-directories-first --git -la"
  alias lt="exa --icons -T"
else
  if [[ "$OSTYPE" == darwin* ]]; then
    alias ls="ls -G"
  else
    alias ls="ls --color --group-directories-first"
  fi
  alias ll="ls -lh"
  alias la="ls -A"
  alias lla="ls -lAh"
  [[ -n $commands[tree] ]] && alias lt="tree -C"
fi

# OTHER ------------------------------------------------------------------------
# Type the name of a directory, and it will become the current directory
setopt autocd

# Sets window title
if [[ "$KITTY_SHELL_INTEGRATION" =~ "no-title" ]]; then
  function set_window_title() {
    case "$TERM" in 
      cygwin|xterm*|putty*|rxvt*|konsole*|ansi|mlterm*|alacritty|st*|foot*|contour*)
        if [ -z "$WT_SESSION" ]; then
          print -Pn "\e]2;${USER}@${HOST}:${PWD/$HOME/~}\a"
        else
          print -Pn "\e]2;${PWD/$HOME/~}\a"
        fi
        ;;
    esac
  }
  
  autoload -Uz add-zsh-hook
  add-zsh-hook precmd set_window_title
fi

# Disable background color on paste
zle_highlight+=(paste:none)

# AFTER CONFIG -----------------------------------------------------------------
[ -f "$ZUNDER_ZSH_DIR/after.zsh" ] && source "$ZUNDER_ZSH_DIR/after.zsh"

# STARTS COMPINIT --------------------------------------------------------------
zicompinit

[[ "$ZINIT[ZCOMPDUMP_PATH].zwc" -nt "$ZINIT[ZCOMPDUMP_PATH]" ]] \
  || zcompile "$ZINIT[ZCOMPDUMP_PATH]"
