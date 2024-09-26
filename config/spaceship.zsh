SPACESHIP_PROMPT_ORDER=(
  dir            # Current directory section
  git            # Git section (git_branch + git_status)
  venv           # virtualenv section
  exec_time      # Execution time
  line_sep       # Line break
  jobs           # Background jobs indicator
  char           # Prompt character
)

SPACESHIP_PROMPT_ADD_NEWLINE=false
_spaceship_add_newline() {
    [ -z "$_should_add_newline" ] && _should_add_newline=true || echo
}
precmd_functions+=(_spaceship_add_newline)

SPACESHIP_CHAR_SYMBOL="❯ "
SPACESHIP_CHAR_COLOR_SUCCESS="reset"

SPACESHIP_DIR_LOCK_SYMBOL=" 󰌾"

SPACESHIP_VENV_PREFIX="using "
SPACESHIP_VENV_SYMBOL=" "
