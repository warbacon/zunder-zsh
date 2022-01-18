# Warbacon's zsh configurator
## Information

This is a simple shell script that sets zsh as the default shell, applies various settings and installs some plugins to make the shell prompt more enjoyable.

Please report any bug or undesired behaviour you encounter.

### Changes made:

- Enables zsh history.
- Adds some new aliases.
- Installs the [Starship prompt](https://starship.rs).
- Replaces the `ls` command for [lsd](https://github.com/Peltoche/lsd).
- Installs the [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions.git) and [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) plugins.

#### New aliases:

| Alias | Command                       |
| ----- | ----------------------------- |
| ls    | lsd (only if is installed)    |
| ll    | ls -l                         |
| q     | exit                          |
| clr   | clear                         |

### Supported Linux distributions:

- Arch based.
- Debian/Ubuntu based.
- Red Hat/Fedora based.
- Android ([Termux](https://termux.com/)).

**WARNING:** Sudo must be installed and configured for the current user.


## Dependecies

**You must install a [Nerd Font](https://www.nerdfonts.com/font-downloads) and set it as default font in your terminal in order to see all the icons correctly.**

**Arch based distributions**

```sh
sudo pacman -Sy git
```

**Debian/Ubuntu based distributions**

```sh
sudo apt-get install wget curl git
```

**Red Hat/Fedora based distributions**

```sh
sudo dnf install util-linux-user git
```

Android (via [Termux](https://termux.com/))

```sh
pkg install git
```

## Usage

1. Clone the repository:
   
   ```sh
   git clone https://github.com/Warbacon/zsh-configurator.git
   ```

2. Navigate to the cloned repository and run the `run.sh` script.
   
   ```sh
   cd ./zsh-configurator
   bash run.sh
   ```

3. Follow the script's installation and enjoy.

## Roadmap

- [x] Make it work on Debian/Ubuntu-based distributions and Fedora.
- [x] Install zsh if it's not.
- [x] Make it work on Android via Termux.
- [x] Add  colors
- [ ] Document code