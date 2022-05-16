# Enable Powerlevel10k instant prompt. --------------------------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Enable history ------------------------------------------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY

# Options -------------------------------------------------------------------------------
autoload -U select-word-style
select-word-style bash
setopt autocd

# Key bindings --------------------------------------------------------------------------
bindkey -e

bindkey "^[[3~" delete-char
bindkey "^[[3;5~" kill-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
bindkey '^[[Z' reverse-menu-complete

# Aliases -------------------------------------------------------------------------------
if hash exa 2> /dev/null; then
    alias ls="exa --icons"
    alias ll="ls -lh --git"
    alias la="ls -a"
    alias lla="ls -lha --git"
else
    alias ls="ls --color"
    alias ll="ls -l"
    alias la="ls -A"
    alias lla="ls -lA"
fi
alias q="exit"
alias clr="clear"
alias ..="cd .."

# Load .dircolors --------------------------------------------------------------------------
if [[ -f .dircolors ]]; then
    eval "$(dircolors -b ~/.dircolors)"
fi

# Load Zinit --------------------------------------------------------------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [[ ! -d "$HOME/.local/share/zinit" ]]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    echo "\033[1;33mInstalling Zinit in $HOME/.local/share/zinit...\033[0m\n"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Fzf integration ----------------------------------------------------------------------------
if hash fzf 2> /dev/null; then
    zinit wait lucid light-mode for OMZP::fzf

    # One Dark colorscheme
    export FZF_DEFAULT_OPTS="--color=fg:#abb2bf,bg:#282c34,hl:#61afef --color=fg+:#d0d0d0,bg+:#343a46,hl+:#61afef \
    --color=info:#d19a66,prompt:#e06c75,pointer:#c678dd --color=marker:#98c379,spinner:#c678dd,header:#56b6c2"
fi

# Plugins -----------------------------------------------------------------------------------
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit wait lucid light-mode for \
    OMZP::sudo \
    Tarrasch/zsh-bd \
    hlissner/zsh-autopair

zinit wait lucid light-mode for \
    atinit"zicompinit; zicdreplay" \
        zdharma-continuum/fast-syntax-highlighting \
    atload"!_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
    blockf atpull'zinit creinstall -q .'\
        zsh-users/zsh-completions

# Command completions ----------------------------------------------------------------------
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

# Start Powerlevel10k ----------------------------------------------------------------------
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
