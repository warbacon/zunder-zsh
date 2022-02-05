# Warbacon zsh configurator

This is a simple bash script that configures zsh the way it should work out of the box. It install a few plugins, adds icons to
the ls command and the prompt and make some basic configuration.

*Please report any bug or undesired behaviour you encounter.*

## Changes made:

- Enables zsh history.
- Adds some new aliases.
- Installs the [Starship prompt](https://starship.rs).
- Replaces the `ls` command with [lsd](https://github.com/Peltoche/lsd).
- Installs the [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions), [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting) and [zsh-autopair](https://github.com/hlissner/zsh-autopair) plugins.
### New aliases:

| Alias | Command                             |
| ----- | -----------------------------       |
| ls    | lsd (only if is installed)          |
| ll    | ls -l                               |
| la    | ls -a                               |
| q     | exit                                |
| clr   | clear                               |

### Supported Linux distributions:

- Arch based.
- Debian/Ubuntu based.
- Red Hat/Fedora based.
- Android ([Termux](https://termux.com/)).

## Dependecies

**You must install a [Nerd Font](https://www.nerdfonts.com/font-downloads) and set it as default font in your terminal in order to see all the icons correctly.**

**WARNING:** Sudo must be installed and configured for the current user.

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

- [x] Make it work on Debian/Ubuntu based distributions and Fedora.
- [x] Install zsh if it's not.
- [x] Make it work on Android via Termux.
- [x] Add  colors
