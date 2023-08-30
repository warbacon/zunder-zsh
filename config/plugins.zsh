# ZINIT ------------------------------------------------------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[[ ! -d $ZINIT_HOME ]] && mkdir -p "$(dirname $ZINIT_HOME)"
[[ ! -d $ZINIT_HOME/.git ]] \
  && git clone --depth=1 https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

# Compiles zinit.zsh if it's newer than its compiled version. Then sources it.
[[ "$ZINIT_HOME/zinit.zsh.zwc" -nt "$ZINIT_HOME/zinit.zsh" ]] \
  || zcompile -R "$ZINIT_HOME/zinit.zsh"
source "$ZINIT_HOME/zinit.zsh"

# CONFIGURATION ----------------------------------------------------------------
if [[ $TERM != "linux" ]]; then
  ZUNDER_PROMPT_CHAR=""
  ZUNDER_PROMPT_CHAR_COLOR=3
fi

# PLUGINS ----------------------------------------------------------------------
# zunder-prompt
zinit light-mode compile'./gitstatus/(install|*.zsh)' depth"1" for \
  Warbacon/zunder-prompt

# zsh plugins
zinit light-mode depth"1" nocd for \
  OMZP::command-not-found \
  OMZP::sudo \
  has"dircolors" \
  Warbacon/zsh-lscolors \
  as"completion" \
  zsh-users/zsh-completions \
  as"completion" has"docker" \
  https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

zinit wait lucid light-mode nocd depth"1" for \
  zdharma-continuum/fast-syntax-highlighting \
  if'[[ $TERM != "linux" ]]' \
  atinit"ZSH_AUTOSUGGEST_MANUAL_REBIND=1" atload"_zsh_autosuggest_start" \
  zsh-users/zsh-autosuggestions
