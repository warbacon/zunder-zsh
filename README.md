# Warbacon zsh configurator

This is a simple bash script that configures zsh the way it should work out of the box. It install a few plugins, adds icons to
the ls command, and the prompt and make some basic configuration.

![example](images/example.png)

*Please report any bug or undesired behaviour you encounter.*

## Changes made:

- Enables zsh history.
- Adds some new aliases.
- Powerfull completions.
- intuitive keybindings.
- Replaces the `ls` command with [exa](https://github.com/ogham/exa).
- Installs the [Powerlevel10k prompt](https://github.com/romkatv/powerlevel10k).
- Installs the [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions), [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting), [zsh-completions](https://github.com/zsh-users/zsh-completions) and [zsh-autopair](https://github.com/hlissner/zsh-autopair) plugins.

### New aliases:

| Alias | Command                      |
| ----- | -----------------------------|
| ll    | ls -l                        |
| la    | ls -a                        |
| lla   | ll -a                        |
| q     | exit                         |
| clr   | clear                        |

### Supported Linux distributions:

- Arch based.
- Debian/Ubuntu based.
- Fedora.
- Android ([Termux](https://termux.com/)).

## Dependecies

**You must install a [Nerd Font](https://www.nerdfonts.com/font-downloads) and set it as default font in your terminal to see all the icons correctly.**

**Arch based distributions**

```sh
sudo pacman -S git
```

**Debian/Ubuntu based distributions**

```sh
sudo apt-get install git
```

**Fedora**

```sh
sudo dnf install util-linux-user
```

**Android** (via [Termux](https://termux.com/))

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
- [x] Add colors to the installer.

**The script will be updated every time I discover new ways to configure the shell.**
