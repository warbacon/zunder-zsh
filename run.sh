#!/bin/bash

source ./lib/color.sh

# FUNCTIONS

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

# Will install Zsh if it's not.
install_zsh() {
    echo "----------------------------------------------------------------------"
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
    echo -e "Zunder will load a custom .zshrc to your current user home directory (${CYAN}$HOME${NORMAL}).\n"
    echo -e "${WARNING}YOUR CURRENT .ZSHRC CONFIGURATION FILE WILL BE BACKED UP WITH THE NAME .ZSHRC.BAK${NORMAL}\n"
    printf "${BOLD}Continue? [y/N]: ${NORMAL}"
    
    read -r prompt
    
    printf "\n"
    case $prompt in
        [yY])
            if [[ -f "$HOME/.zshrc" && ! -f "$HOME/.zshrc.bak" ]]; then
                mv --verbose "$HOME/.zshrc" "$HOME/.zshrc.bak"
            else
                printf "${WARNING}There is a file named .zshrc.bak, so it will not be replaced.${NORMAL}\n"
            fi
            cp --verbose "./config/p10k.zsh" "$HOME/.p10k.zsh"
            cp --verbose "./config/zshrc" "$HOME/.zshrc"
            if [[ $distro = 2 ]]; then
                sed -i 's/ --git//g' "$HOME/.zshrc"
                if [[ $(lsb_release -si 2> /dev/null) = "Ubuntu" ]]; then
                    cp --verbose "./config/zshenv" "$HOME/.zshenv"
                fi
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

    if ! type zsh &>/dev/null; then
        install_zsh
    fi

    if [[ "$SHELL" != "/bin/zsh" && "$SHELL" != "/usr/bin/zsh" && "$SHELL" != "/data/data/com.termux/files/usr/bin/zsh" ]]; then
        zsh_default
    fi

    if ! type exa &>/dev/null; then
        install_exa
    fi

    load_files

    echo "------------"
    printf "${SUCCESS}We are done.${NORMAL}\n"
}

main "$@"
