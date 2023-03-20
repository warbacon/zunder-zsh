# ZINIT ----------------------------------------------------------------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# PLUGINS --------------------------------------------------------------------------------
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

zi ice from"gh-r" as"program"
zi light junegunn/fzf

zi ice from"gh-r" as"program" pick"fd*/fd" if'[[ $(uname -o) != "Android" ]]' \
    atload"FZF_ALT_C_COMMAND=\"fd -H --exclude=.git --type=directory\";
    FZF_CTRL_T_COMMAND=\"fd -H --exclude=.git\""
zi light sharkdp/fd

zi ice from"gh-r" as"program" pick"bin/exa" if'[[ $(uname -o) != "Android" ]]' has"unzip" \
    atclone"cp completions/exa.zsh _exa" at./scripts/auto-install.shpull'%atclone'
zi light ogham/exa

zi snippet OMZL::key-bindings.zsh

zi wait lucid light-mode for \
    OMZP::command-not-found \
    OMZP::sudo \
    https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh \
    as"completion" \
        zsh-users/zsh-completions \
    hlissner/zsh-autopair \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
        zdharma-continuum/fast-syntax-highlighting \
    atload"ZSH_AUTOSUGGEST_MANUAL_REBIND=true;
        _zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions

