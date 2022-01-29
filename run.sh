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

function distro_select() {
    echo -e "\n${ITALIC}Welcome to the ${ITALICRED}Warbacon${NORMAL}${ITALIC} zsh configurator${NORMAL}"
    echo "--------------------------------------------"
    echo -e "1. Arch based (pacman)"
    echo -e "2. Debian/Ubuntu based (apt)"
    echo -e "3. Red Hat/Fedora based (dnf)"
    echo -e "4. Android (termux)\n"
    echo -e "Select your current distro [1-4]${NORMAL}"

    read distro
}

function install_zsh() {
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

function zsh_default() {
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

function starhip_install() {
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

function exa_install() {
    echo "--------------------------------------------------------------------------------------------"
    echo -e "Exa is powerfull ls command replacement written in rust. It will show icons and colors for every file or directory.\n"
    echo -e "${BOLD}Do you want to install ${BLUEBOLD}exa${NORMAL}${BOLD}? [Y/n]${NORMAL}"

    read prompt

    echo ""
    case $prompt in
    [nN])
        noexa=1
        echo -e "${WARNING}Exa won't be installed.${NORMAL}"
        ;;
    *)
        case $distro in
        2)
            echo -e "Exa will be installed.\n"
            wget https://github.com/ogham/exa/releases/download/v0.10.1/exa-linux-x86_64-v0.10.1.zip -O exa.zip
            unzip exa.zip
            sudo mv ./bin/exa /bin
            # sudo apt install exa
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

function lsd_install() {
    echo "--------------------------------------------------------------------------------------------"
    echo -e "Lsd is a beautified ls command. It will show icons and colors for every file or directory.\n"
    echo -e "${BOLD}Do you want to install ${BLUEBOLD}lsd${NORMAL}${BOLD}? [Y/n]${NORMAL}"

    read prompt

    echo ""
    case $prompt in
    [nN])
        noexa=1
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

function install_plugins() {
    echo "-----------------------------------------------------------------------------"
    echo -e "${BLUEBOLD}fast-syntax-highlighting${NORMAL}${BOLD}, ${BLUEBOLD}zsh-ausuggestions${NORMAL}${BOLD} and ${BLUEBOLD}zsh-autopair${NORMAL}${BOLD} are three essential zsh plugins."
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
        git clone https://github.com/zsh-users/zsh-autosuggestions.git "$HOME"/.config/zsh/plugins
        git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git "$HOME"/.config/zsh/plugins
        git clone https://github.com/hlissner/zsh-autopair.git "$HOME"/.config/zsh/plugins
        ;;
    esac
}

function load_zshrc() {
    echo "------------------------------------------------------------------------------------"
    echo -e "At last, we will load a custom .zshrc to your current user home directory (${CYAN}$HOME${NORMAL}).\n"
    echo -e "${WARNING}BACKUP YOUR .ZSHRC BEFORE CONTINUE AS IT WILL BE REPLACED.${NORMAL}\n"
    echo -e "${BOLD}Continue? [y/N]${NORMAL}"

    read prompt

    echo ""
    case $prompt in
    [yY])
        cp zshrc "$HOME"/.zshrc
        cp key-bindings.zsh "$HOME"/.config/zsh
        if  [[ $noexa = 1 ]]; then
            sed "s/exa --icons/ls --color=auto/" zshrc > "$HOME"/.zshrc
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

if [[ "$SHELL" != "/bin/zsh" ]] && [[ "$SHELL" != "/usr/bin/zsh" ]] && [[ "$SHELL" != "/data/data/com.termux/files/usr/bin/zsh" ]]; then
    zsh_default
fi

starhip_install

exa_install

install_plugins

load_zshrc

echo "--------------------------------------------"
echo -e "${SUCCESS}We are done.${NORMAL} 🎉"
