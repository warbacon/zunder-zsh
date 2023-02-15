#!/bin/bash

source ./lib/color.sh
source ./lib/constants.sh

# FUNCTIONS

# Checks if the given command exists in $PATH
command_exists() {
  command -v "$@" >/dev/null 2>&1
}

# Will ask you for your current operating system.
select_system() {
    echo -e "\n${ITALIC}Welcome to the ${ITALICYELLOW}Zunder-zsh${NORMAL}${ITALIC} configuration utility.${NORMAL}"
    echo "------------------------------------------------"
    echo -e "1. Arch based (pacman)"
    echo -e "2. Debian/Ubuntu based (apt)"
    echo -e "3. Fedora (dnf)"
    echo -e "4. Android (termux)\n"
    printf "Select your current operating system [1-4]: "
    
    read -r distro
}

# Checks if the user has installed all dependencies
dependecy_check() {
    echo "----------------------------------------------------------"
    echo "                     DEPENDENCY CHECK                     "
    echo "----------------------------------------------------------" 
    if  ! command_exists zsh; then
        install_zsh
    fi
    if  ! command_exists git; then
        install_git
    fi
}

# Will install Zsh if it's not.
install_zsh() {
    printf "${WARNING}Zsh is not installed, do you want to install it? [Y/n]: ${NORMAL}"
    
    read -r prompt
    
    echo ""
    case $prompt in
        [nN])
            echo -e "${ERROR}Zsh is needed to run the script.${NORMAL}"
            exit
        ;;
        *)
            echo -e "Zsh will be installed.\n"
            case $distro in
                2)
                    sudo apt-get install zsh
                ;;
                3)
                    sudo dnf install zsh
                ;;
                4)
                    pkg install zsh
                ;;
                *)
                    sudo pacman -S zsh
                ;;
            esac
        ;;
    esac
}

# Will install Git if it's not.
install_git() {
    printf "${WARNING}Git is not installed, do you want to install it? [Y/n]: ${NORMAL}"
    
    read -r prompt
    
    printf "\n"
    case $prompt in
        [nN])
            echo -e "${ERROR}Git is needed to run the script.${NORMAL}"
            exit
        ;;
        *)
            echo -e "Git will be installed.\n"
            case $distro in
                2)
                    sudo apt-get install git
                ;;
                3)
                    sudo dnf install git
                ;;
                4)
                    pkg install git
                ;;
                *)
                    sudo pacman -S git
                ;;
            esac
        ;;
    esac
}

# Will set as default Zsh if it's not.
zsh_default() {
    echo "----------------------------------------------------------------------"
    printf "${WARNING}Zsh is not your current defaut shell, do you want to set it? [Y/n]: ${NORMAL}"
    
    read -r prompt
    
    printf "\n"
    case $prompt in
        [Nn])
            echo -e "${WARNING}Zsh won't be setted as the default shell.${NORMAL}"
        ;;
        *)
            if [[ $distro = 3 ]]; then
                sudo usermod -s "$(which zsh)" $USER
            elif [[ $distro = 4 ]]; then
                chsh -s zsh
            else
                chsh -s "$(which zsh)"
            fi
            echo -e "${SUCCESS}Zsh was setted as the default shell, a reboot is needed to see the changes.${NORMAL}"
        ;;
    esac
}

# Will back up your .zshrc and copy the configuration files to yout home directory.
load_files() {
    echo "----------------------------------------------------------------------"
    echo -e "Zunder will will store its configuration in ${CYAN}$ZDOTDIR${NORMAL}.\n"
    printf "${BOLD}Continue? [y/N]: ${NORMAL}"
    
    read -r prompt
    
    printf "\n"
    case $prompt in
        [yY])
            mkdir -p "$ZDOTDIR" 2> /dev/null
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
            echo -e "${WARNING}Canceled. This won't apply your changes at all, try running the script again.${NORMAL}"
        ;;
    esac
}

# START

main() {
    select_system

    if ! command_exists zsh || ! command_exists git; then
        dependecy_check
    fi

    if [[ "$SHELL" != "/bin/zsh" && "$SHELL" != "/usr/bin/zsh" && "$SHELL" != "/data/data/com.termux/files/usr/bin/zsh" ]]; then
        zsh_default
    fi

    load_files

    echo "------------"
    printf "${SUCCESS}We are done.${NORMAL}\n"
}

main "$@"
