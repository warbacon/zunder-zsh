# !/bin/bash

echo "Welcome to the Warbacon's zsh configurer"
echo "--------------------------------------------"
# echo "Supported distros:"
# echo "1. Arch-based distros (pacman)"
# echo "2. Debian/Ubuntu based (apt)"
# echo "3. Red Hat/Fedora based (dnf)"
# echo "Select your current distro [1-3]"
# read $distro

if [ $SHELL != "/bin/zsh" ]; then
    echo "Zsh is not your current defaut shell, do you want to set it? [Y/n]"

    read prompt

    case $prompt in
        [yY])
            chsh -s /bin/zsh
            sudo chsh -s /bin/zsh
            echo "Zsh was setted as the default shell, a reboot is needed to see the changes.";;
        *)
            echo "Ok, zsh won't be setted as the default shell."
    esac
fi
echo ""

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
echo "Are you using an Arch-based distribution? [Y/n]"

while read -r -t 0; do read -r; done
read prompt

echo ""
case $prompt in
    [nN])
        echo "A mamarla.";;
    *)
        echo "Pacman will be used to install the plugins and lsd."
        echo "The plugins will be installed at /usr/share/zsh/plugins, superuser permissions are needed."
        echo ""
        sudo pacman -Sy zsh-syntax-highlighting zsh-autosuggestions lsd;;
esac

echo "At last, we will load a custom .zshrc to your current user home directory ($HOME)."
echo ""
echo "BACKUP YOUR .ZSHRC BEFORE CONTINUE TO RESET THE CONFIGURATION IN CASE YOU WERE NOT SATISFIED."
echo ""
echo "Continue? [y/N]"

while read -r -t 0; do read -r; done
read $prompt

echo ""
case $prompt in
    [yY])
        cp .zshrc $HOME;;
    *)
        echo "Canceled."
esac

echo "--------------------------------------------"
echo "We are done."
