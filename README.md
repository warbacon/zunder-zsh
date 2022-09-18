# Zunder-zsh
*"It's fast, really, really fast! Just get rid of Oh My Zsh already..."*

Zunder is a configuration utility that configures Zsh the way the user expects it to work.
The setup is built on top of Zinit and the Powerlevel10k prompt, so it's as fast as it can be.

![example](./assets/example.avif)

> Using the Gruvbox Dark colorscheme in Kitty with JetBrainsMono Nerd Font

*"You have convinced me, [let's try it out](https://github.com/Warbacon/zunder-zsh#getting-started)!"*

## Features
- Clean and fast.
- Autosuggestions and syntax highlighting. 
- Full [Git](https://git-scm.com/) integration.
- Some useful aliases.
- Compatible with all [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh) and [Prezto](https://github.com/sorin-ionescu/prezto)
plugins and themes. Check out [Zinit](https://github.com/zdharma-continuum/zinit).
- Powerful and lag-free prompt thanks to [Powerlevel10k](https://github.com/romkatv/powerlevel10k).
- Replaces the `ls` command with [exa](https://github.com/ogham/exa).
- [Fzf](https://github.com/junegunn/fzf) integration. Try using ALT+C, CTRL+T and CTRL+R.
- Automatic [fnm](https://github.com/Schniz/fnm) installation.
- Much more and it's updating! See [Installed plugins](https://github.com/Warbacon/zunder-zsh#installed-plugins).

### New aliases:
| Alias | Command                           |
| ----- | --------------------------------- |
| ll    | ls -lh --group-directories-first  |
| la    | ls -A                             |
| lla   | ll -A                             |
| q     | exit                              |
| clr   | clear                             |
| ..    | cd ..                             |

Some of these aliases are adapted to the packages installed on your system.
Check the .zshrc file in your home directory for more info.

### Installed plugins:
- [fast-syntax-hightlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting) - better
and faster than zsh-syntax-highlighting.
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) - suggest previously
executed commands.
- [zsh-completions](https://github.com/zsh-users/zsh-completions) - smarter command completions.
- [zsh-autopair](https://github.com/hlissner/zsh-autopair) - automatically close parentheses,
quotes and more.
- [wd](https://github.com/mfaerevaag/wd) - jump to custom directories without using cd.
- [zsh-fnm](https://github.com/dominik-schwabe/zsh-fnm) - installs and loads Fast Node Manager (fnm).
- [sudo](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo) plugin from Oh My Zsh -
press the Esc key twice to put `sudo` at the beginning.

### Supported operating systems:
- Arch Linux and derivatives (Manjaro, Endeavour OS...).
- Debian/Ubuntu and derivatives (Pop OS, Kubuntu, Linux Mint...).
- Fedora.
- Android (using [Termux](https://termux.com/)).

Might support more in the future, depending on requests.

## Getting started
### Dependencies:
You **must install a [Nerd Font](https://www.nerdfonts.com/font-downloads) and set it as default font in your terminal** to see all the icons correctly. 
On **Android**, you can install [Termux:Styling](https://f-droid.org/es/packages/com.termux.styling) and use for example Fira Code.

**Arch based distributions**

```sh
sudo pacman -S git unzip
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

### Usage:
1. Clone the repository:
   
   ```sh
   git clone https://github.com/Warbacon/zunder-zsh.git
   ```

2. Enter the cloned repository and run the `run.sh` script.
   
   ```sh
   cd ./zunder-zsh
   ./run.sh
   ```

And everything should be ready. 
Zinit will be installed along with all plugins when starting a new zsh instance. 

## Troubleshooting
Zunder is under constant development, so errors may occur. I suggest you open an issue and **I'll help you as fast as I can**. 
Anyway, if you didn't like it or want to go back to your previous configuration, you can run the ``remove.sh`` script located in this same repository:

```bash
./remove.sh
```

Additionally, if you used previously another shell, you can revert it using the following command:
```bash
chsh -s $(which shell)

 # where shell is the name of the shell that you want to revert to, usually bash.
```

### Known bugs
- There is a bug in Arch Linux own of [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting) plugin.
It will not detect your man pages and will highlight them in red. ([#35](https://github.com/zdharma-continuum/fast-syntax-highlighting/issues/35))


## Extra info
Zunder is in active development and not that popular at the moment, so
I'm alone maintaining this thing and it's possible that something unexpected
happens. **I appreciate that bugs are reported and new ideas are suggested.** 
