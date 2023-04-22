# CONSTANTS --------------------------------------------------------------------
OS="$(uname -o || uname)" &> /dev/null
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# ZINIT ------------------------------------------------------------------------
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] \
    && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME" \
    && zcompile "$ZINIT_HOME/zinit.zsh"
source "$ZINIT_HOME/zinit.zsh"

autoload -Uz compinit && compinit
[[ "$ZDOTDIR/.zcompdump.zwc" -nt "$ZDOTDIR/.zcompdump" ]] || zcompile -R "$ZDOTDIR/.zcompdump"

# PLUGINS ----------------------------------------------------------------------
if [ $OS != "Android" ]; then
    zi ice as"command" from"gh-r" \
        atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
        atpull"%atclone" src"init.zsh"
    zi light starship/starship
elif command_exists starship; then
    [ ! -f "$HOME/.cache/starship/init.zsh" ] \
        && mkdir -p "$HOME/.cache/starship" \
        && starship init zsh > "$HOME/.cache/starship/init.zsh"
    source "$HOME/.cache/starship/init.zsh"
fi

if ! command_exists fzf; then
    zi ice from"gh-r" as"program"
    zi light junegunn/fzf
fi

if command_exists unzip && [[ "$OS" != "Android" ]]; then
    zi ice from"gh-r" as"program" pick"bin/exa" \
        atclone"cp completions/exa.zsh _exa" pull'%atclone'
    zi light ogham/exa
fi

zi light-mode for \
    OMZL::key-bindings.zsh \
    OMZP::command-not-found \
    https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh \
    blockf atpull'zinit creinstall -q .' \
        zsh-users/zsh-completions

zi wait lucid light-mode for \
    atclone'(){local f;cd -q →*;for f (*~*.zwc){zcompile -Uz -- ${f}};}' \
    atpull'%atclone' compile'.*fast*~*.zwc' nocd \
        zdharma-continuum/fast-syntax-highlighting \
    atload'_zsh_autosuggest_start' nocd \
        zsh-users/zsh-autosuggestions

# CONFIGURATION ----------------------------------------------------------------
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
FZF_ALT_C_COMMAND="find * -type d 2> /dev/null"
FZF_CTRL_T_COMMAND="find * 2> /dev/null" 

