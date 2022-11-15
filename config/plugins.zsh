# ZINIT ----------------------------------------------------------------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [[ -d "${XDG_DATA_HOME:-${HOME}/.local/share}/zinit" ]]; then
   source "${ZINIT_HOME}/zinit.zsh"
else
    echo "\033[1;33mInstalling plugins.\033[0m\n"
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
    source "${ZINIT_HOME}/zinit.zsh"
fi

# PLUGINS --------------------------------------------------------------------------------
ZSH_AUTOSUGGEST_MANUAL_REBIND=1   # improves performance
export STARSHIP_CONFIG=~/.config/zunder-zsh/starship.toml

# OMZ key-bindings
zinit snippet OMZ::lib/key-bindings.zsh

# fzf plugin
zinit ice has'fzf'
zinit snippet OMZP::fzf

# sudo plugin
zinit ice has'sudo'
zinit snippet OMZP::sudo

# wd plugin and autopairs
zinit wait lucid light-mode for \
    mfaerevaag/wd \
    hlissner/zsh-autopair

# syntax highlighting, autosuggestions and additional completions
zinit wait lucid light-mode for \
    atinit"zicompinit; zicdreplay" \
        zdharma-continuum/fast-syntax-highlighting \
    atload"_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
    blockf atpull'zinit creinstall -q .' \
        zsh-users/zsh-completions

