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
    if  ! command_exists chsh; then
        if [[ $distro = 3 ]]; then
            install_linux_utils
        else
            echo "${WARNING}chsh is not available in your system, so you are not be able to set zsh as default shell.${NORMAL}"
        fi
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
            return 1
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
    
    echo ""
    case $prompt in
        [nN])
            echo -e "${ERROR}Git is needed to run the script.${NORMAL}"
            return 1
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

# Will install Zsh if it's not.
install_linux_utils() {
    printf "${WARNING}Chsh command is not available and you need to install the package util-linux-user.\n Do you want to install it? [Y/n]: ${NORMAL}"
    
    read -r prompt
    
    echo ""
    case $prompt in
        [nN])
            echo -e "${ERROR}Chsh is needed to run the script.${NORMAL}"
            return 1
        ;;
        *)
            echo -e "Util-linux-user will be installed.\n"
            sudo dnf install util-linux-user
        ;;
    esac
}

# Will set as default Zsh if it's not.
zsh_default() {
    echo "----------------------------------------------------------------------"
    printf "${WARNING}Zsh is not your current defaut shell, do you want to set it? [Y/n]: ${NORMAL}"
    
    read -r prompt
    
    echo ""
    case $prompt in
        [yY])
            if [[ $distro = 4 ]]; then
                chsh -s zsh
            else
                chsh -s "$(which zsh)"
            fi
            echo -e "${SUCCESS}Zsh was setted as the default shell, a reboot is needed to see the changes.${NORMAL}"
        ;;
        *)
            echo -e "${WARNING}Zsh won't be setted as the default shell.${NORMAL}"
        ;;
    esac
}

# Will install Starship prompt or update it.
function install_starship() {
    echo "----------------------------------------------------------------------"
    printf "${BOLD}Do you want to install the ${BLUEBOLD}Starship prompt${NORMAL}${BOLD} (${CYANBOLD}https://starship.rs${NORMAL}${BOLD})? [Y/n]:${NORMAL} "

    read prompt

    echo ""
    case $prompt in
    [nN])
        echo -e "${ERROR}Starship is needed.${NORMAL}"
        exit
        ;;
    *)
        echo "Starhip will be instaled."
        if [[ $distro = 4 ]]; then
            pkg install starship
        else
            sh -c "$(curl -fsSL https://starship.rs/install.sh)"
        fi
        ;;
    esac
}

# Will install Exa
install_exa() {
    echo "----------------------------------------------------------------------"
    echo -e "Exa is powerfull ls command replacement written in rust. It will show icons and colors for every file or directory.\n"
    printf "${BOLD}Do you want to install ${BLUEBOLD}exa${NORMAL}${BOLD}? [Y/n]: ${NORMAL}"
    
    read -r prompt
    
    echo ""
    case $prompt in
        [nN])
            echo -e "${WARNING}Exa won't be installed.${NORMAL}"
        ;;
        *)
            echo -e "Exa will be installed.\n"
            case $distro in
                2)
                    sudo apt install exa
                ;;
                3)
                    sudo dnf install exa
                ;;
                4)
                    pkg install exa
                ;;
                *)
                    sudo pacman -S exa
                ;;
            esac
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
            mkdir -p "$HOME/.config/zunder-zsh" 2> /dev/null
            mv --verbose "$HOME/.zsh_history" "$ZDOTDIR" 2> /dev/null
            cp --verbose "./config/zshenv" "$HOME/.zshenv" 
            cp --verbose "./config/zshrc" "$ZDOTDIR/.zshrc" 
            cp --verbose "./config/p10k.zsh" "$ZDOTDIR/.p10k.zsh" 
            cp --verbose "./config/aliases.zsh" "$ZDOTDIR" 
            cp --verbose "./config/plugins.zsh" "$ZDOTDIR" 
            cp --verbose "./config/keybindings.zsh" "$ZDOTDIR" 
            cp --verbose "./config/options.zsh" "$ZDOTDIR" 
            cp --verbose "./config/starship.toml" "$ZDOTDIR" 
            if [[ distro = 2 ]]; then
                sed -i 's/ --git//g' "$ZDOTDIR/aliases.zsh"
            fi
        ;;
        *)
            echo -e "${WARNING}Canceled. This won't apply your changes at all, try running the script again.${NORMAL}"
        ;;
    esac
}

# START

main() {
    select_system

    if ! command_exists zsh || ! command_exists unzip || ! command_exists git || ! command_exists chsh; then
        dependecy_check
    fi

    if [[ "$SHELL" != "/bin/zsh" && "$SHELL" != "/usr/bin/zsh" && "$SHELL" != "/data/data/com.termux/files/usr/bin/zsh" ]]; then
        zsh_default
    fi

    install_starship

    if ! command_exists exa; then
        install_exa
    fi

    load_files

    zsh -i -c exit

    echo "------------"
    printf "${SUCCESS}We are done.${NORMAL}\n"
}

main "$@"
