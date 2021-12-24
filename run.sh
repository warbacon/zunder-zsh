# !/bin/bash

function install_plugins() {
    echo ""
    echo "Now, the plugins' repositories will be cloned at $HOME/.config/zsh/plugins."
    echo ""
    mkdir -p $HOME/.config/zsh
    git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.config/zsh/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting $HOME/.config/zsh/plugins/zsh-syntax-highlighting
}

echo "Welcome to the Warbacon's zsh configurator"
echo "--------------------------------------------"
echo "Supported distros:"
echo "1. Arch-based distros (pacman)"
echo "2. Debian/Ubuntu based (apt)"
echo "3. Red Hat/Fedora based (dnf)"
echo ""
echo "Select your current distro [1-3]"

read distro

if [ $SHELL != "/bin/zsh" ]; then
    echo "--------------------------------------------"
    echo "Zsh is not your current defaut shell, do you want to set it? [Y/n]"

    read prompt

    case $prompt in
        [yY])
            chsh -s /bin/zsh
            echo "Zsh was setted as the default shell, a reboot is needed to see the changes."
            echo "";;
        *)
            echo "Ok, zsh won't be setted as the default shell."
            echo "";;
    esac
fi
echo "----------------------------------------------------------------"
echo "A important part of the configuration is the Starship prompt,"
echo "you can see all the information at https://starship.rs/."
echo ""
echo "Do you want to install Starship? [y/N]"

read prompt

echo ""
case $prompt in
    [yY])
        echo "Starhip will be instaled."
        sh -c "$(curl -fsSL https://starship.rs/install.sh)";;
    *)
        echo "Starship won't be installed.";;
esac


echo "----------------------------------------------------------"
echo "Now, we are gonna install two essential zsh plugins and lsd"
echo "The plugins are zsh-syntax-highlighting and zsh-autosuggestions, and lsd is a beautified ls."
echo ""
echo "Do you agree with this? [Y/n]"

read prompt

echo ""
case $prompt in
    [nN])
        echo "Ok, they will not be installed.";;
    *)
    case $distro in
        2)
            echo "Lsd is not available in the Debian and Ubuntu repositories. The binary file will be downloaded and installed."
            wget https://github.com/Peltoche/lsd/releases/download/0.20.1/lsd_0.20.1_amd64.deb -P $HOME -O lsd.deb ||  (printf "\nWget needs to be installed\n\n" && sudo apt-get install wget && wget https://github.com/Peltoche/lsd/releases/download/0.20.1/lsd_0.20.1_amd64.deb -P $HOME -O lsd.deb
            sudo dpkg -i lsd.deb)
            install_plugins;;
        3)
            echo "Lsd will be installed."
            echo ""
            sudo dnf install lsd fontawesome-fonts.noarch
            install_plugins;;
        *)
            echo "Pacman will be used to install the plugins and lsd."
            echo "The plugins will be installed at /usr/share/zsh/plugins, superuser permissions are needed."
            echo ""
            sudo pacman -Sy zsh-syntax-highlighting zsh-autosuggestions lsd;;
    esac

esac

echo "------------------------------------------------------------------------------------"
echo "At last, we will load a custom .zshrc to your current user home directory ($HOME)."
echo ""
echo "BACKUP YOUR .ZSHRC BEFORE CONTINUE TO RESET THE CONFIGURATION IN CASE YOU WERE NOT SATISFIED."
echo ""
echo "Continue? [y/N]"

read prompt

echo ""
case $prompt in
    [yY])
        if [ $distro == 2 ] || [ $distro == 3 ]
        then
            cp zshrc-alt $HOME/.zshrc
        else
            cp zshrc $HOME/.zshrc
        fi;;
    *)
        echo "Canceled. This will not apply your changes at all, try running the script again.";;
esac

echo "--------------------------------------------"
echo "We are done."
