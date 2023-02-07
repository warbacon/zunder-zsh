# ANTIDOTE PLUGIN MANAGER ----------------------------------------------------------------
if [[ ! -d "$ZDOTDIR/.antidote" ]]; then
    git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote
fi

source ${ZDOTDIR:-~}/.antidote/antidote.zsh

zsh_plugins=${ZDOTDIR:-~}/.zsh_plugins.zsh
plugins_file=${ZDOTDIR:-~}/plugins.txt

# Ensure you have a .zsh_plugins.txt file where you can add plugins.
[[ -f $plugins_file ]] || touch $plugins_file

# Lazy-load antidote.
fpath+=(${ZDOTDIR:-~}/.antidote)
autoload -Uz $fpath[-1]/antidote

# Generate static file in a subshell when .zsh_plugins.txt is updated.
if [[ ! $zsh_plugins -nt $plugins_file ]]; then
  (antidote bundle <$plugins_file >|$zsh_plugins)
fi

# Source your static plugins file.
source $zsh_plugins

autoload -Uz compinit && compinit

# LOAD POWERLEVEL10K ---------------------------------------------------------------------
autoload -Uz promptinit && promptinit && prompt powerlevel10k

# PLUGIN CONFIG --------------------------------------------------------------------------
ZSH_FZF_HISTORY_SEARCH_END_OF_LINE='true'
ZSH_FZF_HISTORY_SEARCH_EVENT_NUMBERS=0
