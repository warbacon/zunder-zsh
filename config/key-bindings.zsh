# KEY BINDINGS ---------------------------------------------------------------------------
bindkey -r emacs "\e\e"                   # unbind double escape to insert sudo
bindkey -M emacs "^[[1;3C" forward-word   # bind alt-right to forward-word
bindkey -M emacs "^[[1;3D" backward-word  # bind alt-left to backward-word
bindkey -M emacs "^[s" sudo-command-line  # bind alt-s to insert sudo

