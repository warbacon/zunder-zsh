# ZINIT ----------------------------------------------------------------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# PLUGINS --------------------------------------------------------------------------------
zi ice depth"1"
zi light "romkatv/powerlevel10k"

zi ice from"gh-r" as"program"
zi light "junegunn/fzf"

zi ice from"gh-r" as"program" pick"fd*/fd" if'[[ $(uname -m) = "x86_64" ]]' \
    atload"FZF_ALT_C_COMMAND=\"fd -H --exclude=.git --type=directory\";
    FZF_CTRL_T_COMMAND=\"fd -H --exclude=.git\""
zi light "sharkdp/fd"

zi ice from"gh-r" as"program" pick"bin/exa" if'[[ $(uname -m) = "x86_64" ]]' has"unzip"
zi light "ogham/exa"
zi ice as"completion" has"exa"
zi snippet "https://raw.githubusercontent.com/ogham/exa/master/completions/zsh/_exa"

zi ice wait lucid
zi light "hlissner/zsh-autopair"

zi snippet OMZP::command-not-found
zi snippet OMZP::sudo
zi snippet OMZL::key-bindings.zsh
zi snippet "https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh"

zi wait lucid light-mode for \
    atinit"zicompinit; zicdreplay" \
        zdharma-continuum/fast-syntax-highlighting \
    atload"ZSH_AUTOSUGGEST_MANUAL_REBIND=false;
           ZSH_AUTOSUGGEST_STRATEGY=(history completion);
           _zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
    blockf atpull'zinit creinstall -q .' \
        zsh-users/zsh-completions

