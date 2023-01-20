# START ZNAP -----------------------------------------------------------------------------------
[[ -f $ZDOTDIR/zsh-snap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git $ZDOTDIR/zsh-snap

source $ZDOTDIR/zsh-snap/znap.zsh

# PLUGINS --------------------------------------------------------------------------------
command_exists() { command -v "$@" >/dev/null 2>&1 }

# Defer execution of a zsh command until zsh has nothing else to do and
# is waiting for user input 
znap source romkatv/zsh-defer

# OMZ plugins
znap source ohmyzsh/ohmyzsh lib/key-bindings.zsh
if command_exists fzf; then
    znap source ohmyzsh/ohmyzsh plugins/fzf
fi
if command_exists sudo; then
    znap source ohmyzsh/ohmyzsh plugins/sudo
fi

# Other plugins
znap source mfaerevaag/wd
zsh-defer znap source hlissner/zsh-autopair

# Syntax highlighting, autosuggestions and additional completions
znap source zsh-users/zsh-completions
zsh-defer znap source zdharma-continuum/fast-syntax-highlighting
zsh-defer znap source zsh-users/zsh-autosuggestions

# Starship prompt
znap eval starship 'starship init zsh --print-full-init'
znap prompt
