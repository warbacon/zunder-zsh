#======================================================
#                       _                       _     
#   _____   _ _ __   __| | ___ _ __     _______| |__  
#  |_  / | | | '_ \ / _` |/ _ \ '__|___|_  / __| '_ \ 
#   / /| |_| | | | | (_| |  __/ | |_____/ /\__ \ | | |
#  /___|\__,_|_| |_|\__,_|\___|_|      /___|___/_| |_|
#                                                     
#======================================================

# LOAD CONFIGURATIONS ----------------------------------------------------------
source "$ZDOTDIR/plugins.zsh"
source "$ZDOTDIR/options.zsh"
source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/key-bindings.zsh"

# LOAD CUSTOM USER CONFIGURATION -----------------------------------------------
[ -f "$ZDOTDIR/user-config.zsh" ] && source "$ZDOTDIR/user-config.zsh"
