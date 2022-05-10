# Zunder zsh configuration

*"It's fast, really, really fast! Just get rid of Oh My Zsh already..."*

Zunder is a simple bash script that configures zsh the way it should work out of the box. It is build on top of Zinit and Powerlevel10k prompt, so it's insanely fast.

![example](images/example.png)

*"You have convinced me, [let's try it out](https://github.com/Warbacon/zunder-zsh#getting-started)!"*

## Features

- Minimal and fast.
- Compatible with all [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh) and [Prezto](https://github.com/sorin-ionescu/prezto) plugins and themes. Check out [Zinit](https://github.com/zdharma-continuum/zinit).
- Powerful and lag-free prompt thanks to [Powerlevel10k](https://github.com/romkatv/powerlevel10k).
- Replaces the `ls` command with [exa](https://github.com/ogham/exa) ([not on Android](https://github.com/Warbacon/zunder-zsh/issues/1#issuecomment-1121312633)).
- [Fzf](https://github.com/junegunn/fzf) integration (only on Arch based distros at this time).
- Fish-like autosuggestions and syntax highlighting. 
- Bash-like key bindings.
- Some useful aliases.
- Much more and it's updating!

*"Umm, that's a lot to be minimal..."*

### New aliases:

| Alias | Command                      |
| ----- | -----------------------------|
| ll    | ls -l                        |
| la    | ls -a                        |
| lla   | ll -a                        |
| q     | exit                         |
| clr   | clear                        |
| ..    | cd ..                        |

Some of these aliases are adapted to the packages installed on your system.
Check the .zshrc file in your home directory for more info.

### Plugins installed:

- [fast-syntax-hightlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting) - better and faster than zsh-syntax-highlighting.
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) - suggest previously executed commands.
- [zsh-completions](https://github.com/zsh-users/zsh-completions) - smarter command completions.
- [zsh-autopair](https://github.com/hlissner/zsh-autopair) - automatically close parentheses, quotes and more
- [sudo](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo) plugin from Oh My Zsh - press the Esc key twice to put ```sudo``` at the beginning.

### Supported operating systems:

- Arch Linux and derivatives (Manjaro, Endeavour OS...).
- Debian/Ubuntu and derivatives (Pop OS, Kubuntu, Linux Mint...).
- Fedora.
- Android (using [Termux](https://termux.com/)).

Might support more in the future, depending on requests.

## Getting started

### Dependencies:

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

**Android** (using [Termux](https://termux.com/))

```sh
pkg install git
```

### Installation:

1. Clone the repository:
   
   ```sh
   git clone https://github.com/Warbacon/zunder-zsh.git
   ```

2. Navigate to the cloned repository and run the `run.sh` script.
   
   ```sh
   cd ./zunder-zsh
   bash run.sh
   ```

3. Follow the script's installation and enjoy.

**Zinit requires you to run the ```zinit update``` command regularly to make sure everything is working properly.**

## Something went wrong?

Zunder is under constant development, so errors may occur. I suggest you open an issue and **I'll help you as fast as I can**. 
Anyway, if you didn't like it or want to go back to your previous settings, you can.

- First of all, **make sure you made a backup of your previous .zshrc file**. It isn't needed if you hadn't configured
anything of your zsh.

- Then, you must remove the .zshrc file in your home directory (```~/.zshrc```) and put there
your backed up file (if you have one).

- You can also remove the p10k.zsh file and the Zinit directories:

```bash
rm -rf ~/.p10k.zsh ~/.local/share/zinit
```

- Additionally, if you used previously another shell, you can revert it using the following command:
```bash
chsh -s $(which shell)

 # where shell is the name of the shell that you want to revert to, usually bash.
```

## Extend your configuration

*Work in progress*

## Extra info

Zunder was born as a personal project to configure the shell of the virtual machines 
that I test and it has become something that I think is amazing, so I am trying hard to measure up.

This is in very active development and not that popular at the moment, so
I'm alone maintaining this thing and it's possible that something unexpected
happens. **I appreciate that bugs are reported and new ideas are suggested.** 