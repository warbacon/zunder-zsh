# ZINIT ------------------------------------------------------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[[ ! -d $ZINIT_HOME ]] && mkdir -p "$(dirname $ZINIT_HOME)"
[[ ! -d $ZINIT_HOME/.git ]] \
    && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

# Compiles zinit.zsh if it's newer than its compiled version. Then sources it.
[[ "$ZINIT_HOME/zinit.zsh.zwc" -nt "$ZINIT_HOME/zinit.zsh" ]] \
    || zcompile -R "$ZINIT_HOME/zinit.zsh"
source "$ZINIT_HOME/zinit.zsh"

# CONFIGURATION ----------------------------------------------------------------
if [[ -n $DISPLAY || -n $TERMUX_VERSION || "$(uname)" == "Darwin" ]]; then
    ZUNDER_PROMPT_CHAR=""
    ZUNDER_PROMPT_CHAR_COLOR=3
fi

# PLUGINS ----------------------------------------------------------------------
# Installs fzf from github releases if it's not installed.
zinit from"gh-r" as"program" if'[[ -z $commands[fzf] ]]' for \
    junegunn/fzf

# Installs exa from github releases, unless the OS is Android as it doesn't work there.
# Android users should install exa from their package manager.
zinit from"gh-r" as"program" pick"bin/exa" \
has"unzip" if'[[ -z $TERMUX_VERSION ]]' \
cp"completions/exa.zsh -> _exa" for \
    ogham/exa

# zunder-prompt
zinit cloneopts"--recursive --shallow-submodules" \
compile'./gitstatus/(install|*.zsh)' for \
    Warbacon/zunder-prompt

# zsh plugins
zinit light-mode depth"1" for \
    OMZP::command-not-found \
    OMZP::sudo \
has"fzf" \
atinit'FZF_ALT_C_COMMAND="find * -type d 2> /dev/null"
       FZF_CTRL_T_COMMAND="find * 2> /dev/null"' \
    https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh \
has"dircolors" \
    Warbacon/zsh-lscolors \
as"completion" \
    zsh-users/zsh-completions \
as"completion" has"docker" \
    https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

zinit wait lucid light-mode depth"1" for \
    zdharma-continuum/fast-syntax-highlighting \
if'[[ -n $DISPLAY || -n $TERMUX_VERSION || "$(uname)" == "Darwin" ]]' \
atinit"ZSH_AUTOSUGGEST_MANUAL_REBIND=1" atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

