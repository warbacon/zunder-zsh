#!/bin/bash

#Output styling
ERROR="\e[1;31m"
WARNING="\e[1;33m"
SUCCESS="\e[3;32m"
ITALICRED="\e[3;31m"
BLUE="\e[34m"
BLUEBOLD="\e[1;34m"
CYAN="\e[36m"
CYANBOLD="\e[1;36m"
BOLD="\e[1m"
ITALIC="\e[3m"
NORMAL="\e[0m"

distro_select() {
    echo -e "\n${ITALIC}Welcome to the ${ITALICRED}Warbacon${NORMAL}${ITALIC} zsh configurator${NORMAL}"
    echo "--------------------------------------------"
    echo -e "1. Arch based (pacman)"
    echo -e "2. Debian/Ubuntu based (apt)"
    echo -e "3. Red Hat/Fedora based (dnf)"
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
            chsh -s /bin/zsh
        fi
        echo -e "${SUCCESS}Zsh was setted as the default shell, a reboot is needed to see the changes.${NORMAL}"
        ;;
    *)
        echo -e "${WARNING}Zsh won't be setted as the default shell.${NORMAL}"
        ;;
    esac
}

starhip_install() {
    echo "-------------------------------------------------------------------------"
    echo -e "${BOLD}Do you want to install the ${BLUEBOLD}Starship prompt${NORMAL}${BOLD} (${CYANBOLD}https://starship.rs${NORMAL}${BOLD})? [Y/n]${NORMAL}"

    read prompt

    echo ""
    case $prompt in
    [nN])
        echo -e "${WARNING}Starship won't be installed.${NORMAL}"
        ;;
    *)
        echo "Starhip will be instaled."
        if [[ $distro = 4 ]]; then
            pkg install starship
        else
            sh -c "$(curl -fsSL https://starship.rs/install.sh)"
        fi
        mkdir -p "$HOME"/.config && cp starship.toml "$HOME"/.config
        ;;
    esac
}

lsd_install() {
    echo "--------------------------------------------------------------------------------------------"
    echo -e "Lsd is a beautified ls command. It will show icons and colors for every file or directory.\n"
    echo -e "${BOLD}Do you want to install ${BLUEBOLD}lsd${NORMAL}${BOLD}? [Y/n]${NORMAL}"

    read prompt

    echo ""
    case $prompt in
    [nN])
        nolsd=1
        echo -e "${WARNING}Lsd won't be installed.${NORMAL}"
        ;;
    *)
        case $distro in
        2)
            echo -e "${WARNING}Lsd isn't available in the Debian and Ubuntu repositories.${NORMAL}"
            echo -e "The binary file will be downloaded and installed.\n"
            wget https://github.com/Peltoche/lsd/releases/download/0.20.1/lsd_0.20.1_amd64.deb -O lsd.deb
            sudo dpkg -i lsd.deb
            ;;
        3)
            echo -e "Lsd will be installed.\n"
            sudo dnf install lsd
            ;;
        4)
            echo -e "Lsd will be installed.\n"
            pkg install lsd
            ;;
        *)
            echo -e "Lsd will be installed.\n"
            sudo pacman -S lsd
            ;;
        esac
        ;;
    esac
}

install_plugins() {
    echo "-----------------------------------------------------------------------------"
    echo -e "${BLUEBOLD}Zsh-syntax-highlighting${NORMAL}${BOLD} and ${BLUEBOLD}zsh-ausuggestions${NORMAL}${BOLD} are two essential zsh plugins."
    echo -e "The plugins' repositories will be cloned at ${CYAN}$HOME/.config/zsh/plugins.${NORMAL}\n"
    echo -e "${BOLD}Do wou want to install the plugins? [Y/n]${NORMAL}"

    read prompt

    echo ""
    case $prompt in
    [nN])
        echo -e "${WARNING}The plugins won't be installed.${NORMAL}"
        ;;
    *)

        mkdir -p "$HOME"/.config/zsh
        git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME"/.config/zsh/plugins/zsh-autosuggestions
        git clone https://github.com/zsh-users/zsh-syntax-highlighting "$HOME"/.config/zsh/plugins/zsh-syntax-highlighting
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
        cp zshrc "$HOME"/.zshrc
        if  [[ $nolsd = 1 ]]; then
            sed "s/lsd/ls --color/" zshrc >> "$HOME"/.zshrc
        fi
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

if [ "$SHELL" != "/bin/zsh" ] && [ "$SHELL" != "/usr/bin/zsh" ] && [ "$SHELL" != "/data/data/com.termux/files/usr/bin/zsh" ]; then
    zsh_default
fi

starhip_install

lsd_install

install_plugins

load_zshrc

echo "--------------------------------------------"
echo -e "${SUCCESS}We are done.${NORMAL} 🎉"
