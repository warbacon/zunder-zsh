# CONSTANTS --------------------------------------------------------------------
OS="$(uname -o)" &> /dev/null
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# ZINIT ------------------------------------------------------------------------
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# PLUGINS ----------------------------------------------------------------------
if [[ $OS != "Android" ]]; then
    zi ice as"program" from"gh-r" \
        atclone"./starship init zsh --print-full-init > init.zsh;
                ./starship completions zsh > _starship" \
        atpull"%atclone" src"init.zsh" nocompile'!'
    zi light starship/starship
elif command_exists starship; then
    [ ! -f "$HOME/.cache/starship/init.zsh" ] \
        && mkdir -p "$HOME/.cache/starship" \
        && starship init zsh > "$HOME/.cache/starship/init.zsh"
    source "$HOME/.cache/starship/init.zsh"
fi

zi ice from"gh-r" as"program" if'! command_exists fzf'
zi light junegunn/fzf

zi ice from"gh-r" as"program" pick"bin/exa" \
    if'[[ $OS != "Android" ]]' has"unzip" \
    atclone"cp completions/exa.zsh _exa" pull'%atclone'
zi light ogham/exa

zi light-mode for \
    OMZL::key-bindings.zsh \
    https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh

zi wait lucid light-mode for \
        OMZP::command-not-found \
        OMZP::sudo \
        hlissner/zsh-autopair \
    atinit"zicompinit; zicdreplay" \
        zdharma-continuum/fast-syntax-highlighting \
    atload"_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
    blockf atpull'zinit creinstall -q .' \
        zsh-users/zsh-completions

# CONFIGURATION ----------------------------------------------------------------
ZSH_AUTOSUGGEST_MANUAL_REBIND=true

FZF_ALT_C_COMMAND="find * -type d -not -path '*/\.git/*'"
FZF_CTRL_T_COMMAND="find * -not -path '*/\.git/*'"

