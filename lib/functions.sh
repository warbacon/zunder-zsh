command_exists() {
    command -v "$@" >/dev/null 2>&1
}

print_error() {
    printf "\n%b%s%b\n" "$RED$BOLD" "$*" "$NORMAL"
}

print_warning() {
    printf "\n%b%s%b\n" "$YELLOW$BOLD" "$*" "$NORMAL"
}

print_success() {
    printf "\n%b%s%b\n" "$GREEN$ITALIC" "$*" "$NORMAL"
}

print_info() {
    printf "\n%b%s %b%s%b\n" "$BLUE$BOLD" "::" "$NORMAL$BOLD" "$*" "$NORMAL"
}

print_line() {
    printf '%*s\n' "$(stty size | cut -d' ' -f2)" '' | tr ' ' '-'
}
