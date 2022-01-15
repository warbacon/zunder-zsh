# !/bin/bash

function distro_select() {
    echo "Welcome to the Warbacon's zsh configurator"
    echo "--------------------------------------------"
    echo "1. Arch based (pacman)"
    echo "2. Debian/Ubuntu based (apt)"
    echo "3. Red Hat/Fedora based (dnf)"
    echo "4. Android (termux)"
    echo ""
    echo "Select your current distro [1-4]"

    read distro
}

function install_zsh() {
    echo "--------------------------------------------------------------------"
    echo "Zsh is not installed, do you want to install it? [Y/n]"

    read prompt

    echo ""
    case $prompt in
    [nN])
        echo "Zsh is needed to run the script."
        ;;
    *)
        echo "Zsh will be installed."
        echo ""

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
    echo "Zsh is not your current defaut shell, do you want to set it? [Y/n]"

    read prompt

    echo ""
    case $prompt in
    [yY])
        if [[ $distro = 4 ]]; then
            chsh -s zsh
        else
            chsh -s /bin/zsh
        fi
        echo "Zsh was setted as the default shell, a reboot is needed to see the changes."
        ;;
    *)
        echo "Ok, zsh won't be setted as the default shell."
        ;;
    esac
}

function starhip_install() {
    echo "-------------------------------------------------------------------------"
    echo "Do you want to install the Starship prompt (https://starship.rs)? [Y/n]"

    read prompt

    echo ""
    case $prompt in
    [nN])
        echo "Starship won't be installed."
        ;;
    *)
        echo "Starhip will be instaled."
        if [[ $distro = 4 ]]; then
            pkg install starship
        else
            sh -c "$(curl -fsSL https://starship.rs/install.sh)"
        fi
        mkdir -p $HOME/.config && cp starship.toml $HOME/.config
        ;;
    esac
}

function lsd_install() {
    echo "--------------------------------------------------------------------------------------------"
    echo "Lsd is a beautified ls command. It will show icons and colors for every file or directory."
    echo ""
    echo "Do you want to install lsd? [Y/n]"

    read prompt

    echo ""
    case $prompt in
    [nN])
        nolsd=1
        echo "Lsd won't be installed."
        ;;
    *)
        case $distro in
        2)
            echo "Lsd is not available in the Debian and Ubuntu repositories. The binary file will be downloaded and installed."
            wget https://github.com/Peltoche/lsd/releases/download/0.20.1/lsd_0.20.1_amd64.deb -P $HOME -O lsd.deb
            sudo dpkg -i lsd.deb
            ;;
        3)
            echo "Lsd will be installed."
            echo ""
            sudo dnf install lsd
            ;;
        4)
            echo "Lsd will be installed."
            echo ""
            pkg install lsd
            ;;
        *)
            echo "Lsd will be installed."
            echo ""
            sudo pacman -S lsd
            ;;
        esac
        ;;
    esac
}

function install_plugins() {
    echo "-----------------------------------------------------------------------------"
    echo "Zsh-syntax-highlighting and zsh-ausuggestions are two essential zsh plugins."
    echo "The plugins' repositories will be cloned at $HOME/.config/zsh/plugins."
    echo ""
    echo "Do wou want to install the plugins? [Y/n]"

    read prompt

    echo ""
    case $prompt in
    [nN])
        echo "The plugins won't be installed."
        ;;
    *)

        mkdir -p $HOME/.config/zsh
        git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.config/zsh/plugins/zsh-autosuggestions
        git clone https://github.com/zsh-users/zsh-syntax-highlighting $HOME/.config/zsh/plugins/zsh-syntax-highlighting
        ;;
    esac
}

function load_zshrc() {
    echo "------------------------------------------------------------------------------------"
    echo "At last, we will load a custom .zshrc to your current user home directory ($HOME)."
    echo ""
    echo "BACKUP YOUR .ZSHRC BEFORE CONTINUE AS IT WILL BE REPLACED."
    echo ""
    echo "Continue? [y/N]"

    read prompt

    echo ""
    case $prompt in
    [yY])
        cp zshrc $HOME/.zshrc
        if  [[ $nolsd = 1 ]]; then
            sed -i '15d' $HOME/.zshrc
        fi
        ;;
    *)
        echo "Canceled. This will not apply your changes at all, try running the script again."
        ;;
    esac
}

distro_select

if ! type zsh &>/dev/null; then
    install_zsh
fi

if [ $SHELL != "/bin/zsh" ] && [ $SHELL != "/usr/bin/zsh" ] && [ $SHELL != "/data/data/com.termux/files/usr/bin/zsh" ]; then
    zsh_default
fi

starhip_install

lsd_install

install_plugins

load_zshrc

echo "--------------------------------------------"
echo "We are done."
