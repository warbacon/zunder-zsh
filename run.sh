#!/bin/bash

#Output styling
ERROR="\033[1;31m"
WARNING="\033[1;33m"
SUCCESS="\033[3;32m"
ITALICRED="\033[3;31m"
BLUE="\033[34m"
BLUEBOLD="\033[1;34m"
CYAN="\033[36m"
CYANBOLD="\033[1;36m"
BOLD="\033[1m"
ITALIC="\033[3m"
NORMAL="\033[0m"

distro_select() {
    echo -e "\n${ITALIC}Welcome to the ${ITALICRED}Warbacon${NORMAL}${ITALIC} zsh configurator${NORMAL}"
    echo "--------------------------------------------"
    echo -e "1. Arch based (pacman)"
    echo -e "2. Debian/Ubuntu based (apt)"
    echo -e "3. Fedora (dnf)"
    echo -e "4. Android (termux)\n"
    echo -e "Select your current distro [1-4]${NORMAL}"
    
    read distro
}

install_zsh() {
    echo "--------------------------------------------------------------------"
    echo -e "${WARNING}Zsh is not installed, do you want to install it? [Y/n]${NORMAL}"
    
    read prompt
    
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

zsh_default() {
    echo "--------------------------------------------------------------------"
    echo -e "${WARNING}Zsh is not your current defaut shell, do you want to set it? [Y/n]${NORMAL}"
    
    read prompt
    
    echo ""
    case $prompt in
        [yY])
            if [[ $distro = 4 ]]; then
                chsh -s zsh
            else
                chsh -s $(which zsh)
            fi
            echo -e "${SUCCESS}Zsh was setted as the default shell, a reboot is needed to see the changes.${NORMAL}"
        ;;
        *)
            echo -e "${WARNING}Zsh won't be setted as the default shell.${NORMAL}"
        ;;
    esac
}

exa_install() {
    echo "--------------------------------------------------------------------------------------------"
    echo -e "Exa is powerfull ls command replacement written in rust. It will show icons and colors for every file or directory.\n"
    echo -e "${BOLD}Do you want to install ${BLUEBOLD}exa${NORMAL}${BOLD}? [Y/n]${NORMAL}"
    
    read prompt
    
    echo ""
    case $prompt in
        [nN])
            echo -e "${WARNING}Exa won't be installed.${NORMAL}"
        ;;
        *)
            case $distro in
                2)
                    echo -e "Exa will be installed.\n"
                    sudo apt install exa
                ;;
                3)
                    echo -e "Exa will be installed.\n"
                    sudo dnf install exa
                ;;
                4)
                    echo -e "Exa will be installed.\n"
                    pkg install exa
                ;;
                *)
                    echo -e "Exa will be installed.\n"
                    sudo pacman -S exa
                ;;
            esac
        ;;
    esac
}

load_zshrc() {
    echo "------------------------------------------------------------------------------------"
    echo -e "At last, we will load a custom .zshrc to your current user home directory (${CYAN}$HOME${NORMAL}).\n"
    echo -e "${WARNING}BACKUP YOUR .ZSHRC BEFORE CONTINUE AS IT WILL BE REPLACED.${NORMAL}\n"
    echo -e "${BOLD}Continue? [y/N]${NORMAL}"
    
    read prompt
    
    echo ""
    case $prompt in
        [yY])
            cp ./config/zshrc ~/.zshrc
            cp ./config/p10k.zsh ~/.p10k.zsh
        ;;
        *)
            echo -e "${WARNING}Canceled. This won't apply your changes at all, try running the script again.${NORMAL}"
        ;;
    esac
}

distro_select

if ! type zsh &>/dev/null; then
    install_zsh
fi

if [ "$SHELL" != "/bin/zsh" -a "$SHELL" != "/usr/bin/zsh" -a "$SHELL" != "/data/data/com.termux/files/usr/bin/zsh" ]; then
    zsh_default
fi

if [ $distro -ne 4 ]; then
    exa_install
fi

load_zshrc

echo "--------------------------------------------"
echo -e "${SUCCESS}We are done.${NORMAL} 🎉"