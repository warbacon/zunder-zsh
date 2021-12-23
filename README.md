# Warbacon's zsh configurer

**WARNING:** Only compatible with Arch-based distributions and zsh will not be installed by default at the moment, you should install it first. Sudo must be installed and configured for the current user.

## Information

This a simple bash script that configures the shell to be the default shell and applies some configuratons and installs plugins to make your shell prompt pretty confortable.

### Changes made:

- Enables zsh history.
- Adds some new aliases.
- Installs [Starship prompt](https://starship.rs).
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
    git clone https://github.com/Warbacon/zsh-configurer.git
    ```

2. Navigate to the cloned project folder and run the ```run.bash``` script.
   
   ```bash
   cd ./zsh-configurer
   ./run.bash
   ```

3. Follow the script's installation and enjoy.

