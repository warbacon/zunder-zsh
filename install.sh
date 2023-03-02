#!/bin/bash

source ./lib/color.sh
source ./lib/constants.sh

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
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
}

install_program() {
    print_warning "$1 is not installed and is required."
    printf "\nContinue? [Y/n]: "

    read -r prompt

    case $prompt in
        [Nn])
            print_error "$1 is required."
            exit 1
            ;;
        *)
            printf "\n"
            case $distro in
                1)
                    sudo pacman -S "$1" ;;
                2)
                    sudo apt install "$1";;
                3)
                    sudo dnf install "$1";;
                4)
                    pkg install "$1";;
                *)
                    print_error "An error has ocurred.";;
            esac
            ;;
    esac
    unset prompt
}

select_system() {
    distro=0
    while [[ "$distro" -lt 1 || "$distro" -gt 4 ]]; do
        printf "\n%bWelcome to the %bzunder-zsh%b installation script.%b\n" \
               "$ITALIC" "$YELLOW" "$NORMAL$ITALIC" "$NORMAL"
        print_line
        echo "1. Arch based (pacman)"
        echo "2. Debian/Ubuntu based (apt)"
        echo "3. Fedora based (dnf)"
        echo "4. Android (termux)"
        printf "\nSelect your current operating system [1-4]: "

        read -r distro

        if [[ ! "$distro" =~ ^[0-9]+$ ]]; then
            distro=0 
        fi

        if [[ "$distro" -lt 1 || "$distro" -gt 4 ]]; then
            print_error "Value entered is invalid."
        fi
    done

    case $distro in
        1)
            distro_name="Arch based";;
        2)
            distro_name="Debian/Ubuntu based";;
        3)
            distro_name="Fedora based";;
        4)
            distro_name="Android";;
        *)
            distro_name="an unknown distro";;
    esac
    print_info "You entered $distro_name."
}

dependecy_check() {
    printf "\n"
    print_line
    echo "DEPENDENCY CHECK"
    print_line

    if ! command_exists zsh; then
        install_program zsh
    fi
    if ! command_exists git; then
        install_program git
    fi
}

set_default() {
    print_line
    printf "Zsh is not your current defaut shell, do you want to set it? [Y/n]: "

    read -r prompt

    case $prompt in
        [Nn])
            print_warning "Zsh won't be setted as the default shell."
            ;;
        *)
            printf "\n"
            if [[ $distro -ne 4 ]]; then
                sudo usermod -s "$(which zsh)" "$USER" && default_applied=true
            else
                chsh -s zsh && default_applied=true
            fi
            if $default_applied; then
                print_success "Zsh was setted as the default shell."
            else
                print_warning "Zsh was not setted as the default shell."
            fi
            ;;
    esac
    unset prompt
}

load_files() {
    print_line
    printf "Zunder-zsh will store its configuration in %b%s%b.\n" \
           "$CYAN" "$ZDOTDIR" "$NORMAL"
    printf "Continue? [y/N]: "

    read -r prompt

    case $prompt in
        [yY])
            printf "\n"
            mkdir --verbose -p "$ZDOTDIR" 2> /dev/null
            cp --verbose ./config/.p10k.zsh "$ZDOTDIR"
            cp --verbose ./config/aliases.zsh "$ZDOTDIR"
            cp --verbose ./config/options.zsh "$ZDOTDIR"
            cp --verbose ./config/key-bindings.zsh "$ZDOTDIR"
            cp --verbose ./config/plugins.zsh "$ZDOTDIR"
            cp --verbose ./config/.zshrc "$ZDOTDIR"
            cp --verbose ./config/.zshenv "$HOME"
            mv --verbose "$HOME/.zsh_history" "$ZDOTDIR" 2> /dev/null
            ;;
        *)
            print_error "Canceled. This won't apply your changes at all," \
                        "try running the script again."
            exit 1
            ;;
    esac
    unset prompt
}

main() {
    select_system

    if ! command_exists zsh || ! command_exists git; then
        dependecy_check
    fi

    default_applied=false
    if [[ $(basename "$SHELL") != "zsh" ]]; then
        set_default
    fi

    load_files

    if [[ ! -d "$HOME/.local/share/zinit" ]]; then
        print_info "Installing zunder-zsh..."
        zsh -i -c exit
    fi

    print_line
    print_success "All done."

    if $default_applied; then
        print_warning "It may be necessary to reboot the system to see" \
                      "zsh as the default shell."
    fi
}

main "$@"
