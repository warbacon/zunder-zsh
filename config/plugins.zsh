# ZINIT ----------------------------------------------------------------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
ZINIT_PLUGINS="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/plugins"

[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && (echo "el pepe"; git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME")
source "${ZINIT_HOME}/zinit.zsh"

# PLUGINS --------------------------------------------------------------------------------
zinit ice depth"1"
zinit light romkatv/powerlevel10k

zi ice from"gh-r" as"program"
zi light junegunn/fzf

zi ice from"gh-r" as"program" pick"bin/exa"
zi light ogham/exa
zi ice as"completion" 
zi snippet "$ZINIT_PLUGINS/ogham---exa/completions/exa.zsh"


zi ice wait lucid
zi light hlissner/zsh-autopair

WD_CONFIG="$ZDOTDIR/.warprc"
zi ice wait lucid \
    atclone"[ ! -f $WD_CONFIG ] && touch $WD_CONFIG" 
zi light mfaerevaag/wd

zi snippet OMZP::command-not-found
zi snippet OMZP::sudo
zi snippet OMZL::key-bindings.zsh
zi snippet "https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh"

zi wait lucid light-mode for \
    atinit"zicompinit; zicdreplay" \
        zdharma-continuum/fast-syntax-highlighting \
    atload"_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
    blockf atpull'zinit creinstall -q .' \
        zsh-users/zsh-completions

# FNM INSTALLATION -----------------------------------------------------------------------
zi ice from"gh-r" as"program"
zi light "Schniz/fnm"

if [[ ! -f "$ZINIT[COMPLETIONS_DIR]/_fnm" ]]; then
    echo "$(fnm completions)" >> "$ZINIT[COMPLETIONS_DIR]/_fnm"
fi

zi light "mroth/evalcache"
_evalcache fnm env
