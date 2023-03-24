#!/bin/bash

source ./lib/color.sh
source ./lib/functions.sh
source ./lib/constants.sh

select_system() {
    local distro_name
        
    printf "\n%bWelcome to the %bzunder-zsh%b installation script.%b\n" \
           "$ITALIC" "$YELLOW" "$NORMAL$ITALIC" "$NORMAL"
    print_line
    echo "1. Arch based (pacman)"
    echo "2. Debian/Ubuntu based (apt)"
    echo "3. Fedora based (dnf)"
    echo "4. Android (termux)"
    printf "\nSelect your current operating system [1-4]: "

    read -r distro

    while [[ "$distro" -lt 1 || "$distro" -gt 4 || ! "$distro" =~ ^[0-9]+$ ]]; do
        print_error "Value entered is invalid."
        printf "\nSelect your current operating system [1-4]: "
        read -r distro
    done

    case $distro in
        1) distro_name="Arch based";;
        2) distro_name="Debian/Ubuntu based";;
        3) distro_name="Fedora based";;
        4) distro_name="Android";;
        *) distro_name="an unknown distro";;
    esac
    print_info "You entered $distro_name."
}

dependecy_check() {
    declare -a dependencies=("zsh" "unzip" "curl" "git")

    print_line
    echo "DEPENDENCY CHECK"
    print_line

    if (( distro == 3 )); then
        dependencies+=("sqlite3")
    fi

    if (( distro == 4 )); then
        dependencies+=("starship" "fd" "exa" "file")
    fi

    not_installed=0
    for dependency in "${dependencies[@]}"; do
        if ! command_exists "$dependency"; then
            if [ "$dependency" == "sqlite3" ]; then
                install_program sqlite
            else
                install_program "$dependency"
            fi
            (( not_installed++ ))
        fi
    done

    if (( not_installed == 0 )); then
        print_success "All dependencies are satisfied."
    fi
}

install_program() {
    local prompt

    print_warning "$1 is not installed and is required."
    printf "\nContinue? [Y/n]: "

    read -r prompt
    prompt=${prompt:-Y}

    if [[ "$prompt" =~ [Nn] ]]; then
        print_error "$1 is required."
        exit 1
    fi

    printf "\n"
    case $distro in
        1) sudo pacman -S "$1" ;;
        2) sudo apt install "$1" ;;
        3) sudo dnf install "$1" ;;
        4) pkg install "$1" ;;
        *) print_error "An error has occurred." ;;
    esac
}

set_default() {
    local prompt

    print_line
    printf "Zsh is not your current defaut shell, do you want to set it? [Y/n]: "

    read -r prompt

    case $prompt in
        [Nn])
            print_warning "Zsh won't be setted as the default shell."
            ;;
        *)
            if (( distro != 4 )); then
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
}

load_files() {
    local prompt

    print_line
    printf "Zunder-zsh will store its configuration in %b%s%b.\n" \
           "$CYAN" "$ZDOTDIR" "$NORMAL"
    printf "Continue? [y/N]: "

    read -r prompt

    case $prompt in
        [yY])
            printf "\n"
            mkdir --verbose -p "$ZDOTDIR" 2> /dev/null
            cp --verbose ./config/starship.toml "$ZDOTDIR"
            cp --verbose ./config/aliases.zsh "$ZDOTDIR"
            cp --verbose ./config/options.zsh "$ZDOTDIR"
            cp --verbose ./config/key-bindings.zsh "$ZDOTDIR"
            cp --verbose ./config/plugins.zsh "$ZDOTDIR"
            cp --verbose ./config/.zshrc "$ZDOTDIR"
            cp --verbose ./config/.zshenv "$HOME"
            mv --verbose "$HOME/.zsh_history" "$ZDOTDIR" 2> /dev/null
            [ ! -f "$ZDOTDIR/user-config.zsh" ] && \
                echo "# Write your configurations here" > "$ZDOTDIR/user-config.zsh"
            ;;
        *)
            print_error "Canceled. This won't apply your changes at all," \
                        "try running the script again."
            exit 1
            ;;
    esac
}

install_icons() {
    print_info "Installing icons..."

    # Create directory if it does not exist
    mkdir -p "$HOME/.local/share/fonts"

    # Download font file if it does not exist
    cd "$HOME/.local/share/fonts" || return 1
    curl -fLo "Symbols Nerd Font.ttf" \
        "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/NerdFontsSymbolsOnly/complete/Symbols-1000-em%20Nerd%20Font%20Complete.ttf" \
        || return 1

    print_success "Icons installed successfully."
    cd - || print_error "Can't return."
}

main() {
    declare -i distro
    default_applied=false

    select_system

    dependecy_check

    if [ "$(basename "$SHELL")" != "zsh" ]; then
        set_default
    fi

    load_files

    if [ ! -d "$HOME/.local/share/zinit" ]; then
        print_info "Installing zunder-zsh..."
        zsh -i -c exit
    fi

    if [[ ! -f "$HOME/.local/share/fonts/Symbols Nerd Font.ttf" && $distro -ne 4 ]]; then
        install_icons
    fi

    print_line
    print_success "All done."

    if $default_applied; then
        print_warning "It may be necessary to reboot the system to see" \
                      "zsh as the default shell."
    fi
}

main "$@"
