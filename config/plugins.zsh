# ZINIT ----------------------------------------------------------------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# PLUGIN CONFIGURATIONS ------------------------------------------------------------------
ZSH_AUTOSUGGEST_MANUAL_REBIND=false
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
WD_CONFIG="$ZDOTDIR/.warprc"
ZSH_EVALCACHE_DIR="$ZINIT[HOME_DIR]/zsh-evalcache"
FNM_DIR="$HOME/.local/share/fnm"

# PLUGINS --------------------------------------------------------------------------------
zinit ice depth"1"
zinit light romkatv/powerlevel10k

zi ice from"gh-r" as"program"
zi light junegunn/fzf

zi ice from"gh-r" as"program" pick"bin/exa"
zi light ogham/exa
zi ice as"completion" 
zi snippet "$ZINIT[PLUGINS_DIR]/ogham---exa/completions/exa.zsh"

zi ice wait lucid
zi light hlissner/zsh-autopair

zi ice wait lucid \
    atclone"[ ! -f $WD_CONFIG ] && touch $WD_CONFIG" 
zi light mfaerevaag/wd
zi ice as"completion"
zi snippet "$ZINIT[PLUGINS_DIR]/mfaerevaag---wd/_wd.sh"

zi snippet OMZP::command-not-found
zi snippet OMZP::sudo
zi snippet OMZL::key-bindings.zsh
zi snippet "https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh"

[ ! -d "$FNM_DIR" ] && \
    curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell
export PATH="$PATH:$FNM_DIR"
[ ! -f "$FNM_DIR/_fnm" ] && fnm completions > "$FNM_DIR/_fnm"
zi ice as"completion"
zi snippet "$FNM_DIR/_fnm"

zi ice atload"_evalcache fnm env --use-on-cd"
zi light "mroth/evalcache"

zi wait lucid light-mode for \
    atinit"zicompinit; zicdreplay" \
        zdharma-continuum/fast-syntax-highlighting \
    atload"_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
    blockf atpull'zinit creinstall -q .' \
        zsh-users/zsh-completions

