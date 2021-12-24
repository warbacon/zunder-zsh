# Warbacon's zsh configurator

**WARNING:** Only compatible with Arch-based distributions and zsh will not be installed by default at the moment, you should install it first. Sudo must be installed and configured for the current user.

## Information

This is a simple shell script that sets zsh as the default shell, applies various settings and installs some plugins to make the shell prompt more enjoyable.

### Changes made:

- Enables zsh history.
- Adds some new aliases.
- Installs the [Starship prompt](https://starship.rs).
- Replaces the ```ls``` command for [lsd](https://github.com/Peltoche/lsd).
- Installs the [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions.git) and [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) plugins.

#### New aliases:

| Alias | Command |
|-------|---------|
| ls    | lsd     |
| ll    | lsd -l  |
| q     | exit    |
| clr   | clear   |

## Installation

Make sure that zsh is installed. It can be installed in Arch-based distributions using:

```bash
sudo pacman -Sy zsh
```

1. Clone the repository:
   
    ```bash
    git clone https://github.com/Warbacon/zsh-configurator.git
    ```

2. Navigate to the cloned project folder and run the ```run.sh``` script.
   
   ```bash
   cd ./zsh-configurator
   bash run.sh
   ```

3. Follow the script's installation and enjoy.

## Roadmap

- Make it work in Debian/Ubuntu-based distributions and Fedora.
- Install zsh if it's not.
- Clean up the code.
- Make it work in Mac OS (?).
