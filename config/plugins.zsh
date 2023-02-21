# ZINIT ----------------------------------------------------------------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
ZINIT_PLUGINS="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/plugins"

[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && (printf "\033[1;33mInstalling plugins...\033[0m\n"; \
git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME")
source "${ZINIT_HOME}/zinit.zsh"

# PLUGIN CONFIGURATIONS ------------------------------------------------------------------
ZSH_AUTOSUGGEST_MANUAL_REBIND=false
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
WD_CONFIG="$ZDOTDIR/.warprc"

# PLUGINS --------------------------------------------------------------------------------
zinit ice depth"1"
zinit light romkatv/powerlevel10k

zi ice from"gh-r" as"program"
zi light junegunn/fzf

zi ice from"gh-r" as"program" pick"bin/exa"
zi light ogham/exa
zi ice as"completion" 
zi snippet "$ZINIT_PLUGINS/ogham---exa/completions/exa.zsh"

zi ice from"gh-r" as"program"
zi light "Schniz/fnm"
zinit light NICHOLAS85/z-a-eval
zi ice eval"fnm env" atclone"fnm completions >> $ZINIT[COMPLETIONS_DIR]/_fnm"
zi light "zdharma-continuum/null"

zi ice wait lucid
zi light hlissner/zsh-autopair

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

