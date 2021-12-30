# !/bin/bash

function distro_select() {
    echo "Welcome to the Warbacon's zsh configurator"
    echo "--------------------------------------------"
    echo "1. Arch based (pacman)"
    echo "2. Debian/Ubuntu based (apt)"
    echo "3. Red Hat/Fedora based (dnf)"
    echo ""
    echo "Select your current distro [1-3]"

    read distro
}

function install_zsh() {
    echo "--------------------------------------------------------------------"
    echo "Zsh is not installed, do you want to install it? [Y/n]"

    read prompt

    echo ""
    case $prompt in
        [nN])
            echo "Zsh is needed to run the script.";;
        *)
            echo "Zsh will be installed."
            echo ""

            case $distro in
                2)
                    sudo apt-get install zsh;;
                3)
                    sudo dnf install zsh;;
                *)
                    sudo pacman -S zsh;;
            esac;;
    esac
}

function zsh_default() {
    if [ $SHELL != "/bin/zsh" ] && [ $SHELL != "/usr/bin/zsh" ]; then
    echo "--------------------------------------------------------------------"
    echo "Zsh is not your current defaut shell, do you want to set it? [Y/n]"

    read prompt

    echo ""
    case $prompt in
        [yY])
            chsh -s /bin/zsh
            echo "Zsh was setted as the default shell, a reboot is needed to see the changes.";;
        *)
            echo "Ok, zsh won't be setted as the default shell.";;
    esac
    fi
}

function starhip_install() {
    echo "-------------------------------------------------------------------------"
    echo "Do you want to install the Starship prompt (https://starship.rs)? [Y/n]"

    read prompt

    echo ""
    case $prompt in
        [nN])
            echo "Starship won't be installed.";;
        *)

            echo "Starhip will be instaled."
            sh -c "$(curl -fsSL https://starship.rs/install.sh)"
            cp starship.toml $HOME/.config;;
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
        echo "Lsd won't be installed.";;
    *)
    case $distro in
        2)
            echo "Lsd is not available in the Debian and Ubuntu repositories. The binary file will be downloaded and installed."
            wget https://github.com/Peltoche/lsd/releases/download/0.20.1/lsd_0.20.1_amd64.deb -P $HOME -O lsd.deb
            sudo dpkg -i lsd.deb;;
        3)
            echo "Lsd will be installed."
            echo ""
            sudo dnf install lsd;;
        *)
            echo "Lsd will be installed."
            echo ""
            sudo pacman -S lsd;;
    esac
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
            echo "The plugins won't be installed.";;
        *)

            mkdir -p $HOME/.config/zsh
            git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.config/zsh/plugins/zsh-autosuggestions
            git clone https://github.com/zsh-users/zsh-syntax-highlighting $HOME/.config/zsh/plugins/zsh-syntax-highlighting;;
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
            cp zshrc $HOME/.zshrc;;
        *)
            echo "Canceled. This will not apply your changes at all, try running the script again.";;
    esac
}

distro_select

if  ! type zsh &> /dev/null
then
    install_zsh
fi

zsh_default

starhip_install

lsd_install

install_plugins

load_zshrc

echo "--------------------------------------------"
echo "We are done."
