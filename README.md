# ⚡ Zunder-zsh

**Zunder-zsh** is a zsh configuration designed to make your terminal experience amazing.

![example](./assets/preview.gif)

## 🪧 Features
- Clean and fast.
- Autosuggestions and syntax highlighting. 
- Beautiful and lag-free custom prompt thanks to
[Powerlevel10k](https://github.com/romkatv/powerlevel10k).
- Replaces the `ls` command with [exa](https://github.com/ogham/exa).
- Full [Git](https://git-scm.com/) integration.
- [Fzf](https://github.com/junegunn/fzf) integration. Try using ALT+C, CTRL+T and CTRL+R.
- Compatible with all [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh) plugins.
Check out [zinit](https://github.com/zdharma-continuum/zinit).
- Much more and it's updating! 
See [Installed plugins](https://github.com/Warbacon/zunder-zsh#installed-plugins).

### New aliases
| Alias | Command                                         |
| ----- | ----------------------------------------------- |
| ..    | Change to the upper directory                   |
| q     | exit                                            |
| clr   | clear                                           |
| ll    | Long list directory contents                    |
| la    | List directory contents with hidden files       |
| lla   | Long list directory contents with hidden files  |

### Installed plugins
- [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting) - syntax
highlighting for zsh.
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) - suggests previously
executed commands.
- [zsh-completions](https://github.com/zsh-users/zsh-completions) - smarter command completions.
- [zsh-autopair](https://github.com/hlissner/zsh-autopair) - automatically closes parentheses,
quotes and more.
- [sudo](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo) plugin from Oh My Zsh -
press the Esc key twice to put `sudo` at the beginning.
- [command-not-found](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/command-not-found) plugin from Oh My Zsh -
suggests installing the required program automatically if it does not find the entered command.

### Supported operating systems
- Arch Linux and derivatives (Manjaro, Endeavour OS...).
- Debian/Ubuntu and derivatives (Pop OS, Kubuntu, Linux Mint...).
- Fedora and derivatives (Ultramarine Linux, Nobara...).
- Android (using [Termux](https://termux.com/)).

Might support more in the future, depending on requests.

## 🚀 Getting started
### Dependencies
Although icons will be installed automatically, is **recommended to install 
a [Nerd Font](https://www.nerdfonts.com/font-downloads) 
and set it as default font in your terminal**. On **Android**, you can install 
[Termux:Styling](https://f-droid.org/es/packages/com.termux.styling) and use for example Fira Code.

Only the following packages are needed to get everything working as intended:
- zsh
- git
- curl
- unzip

**If your operating system is supported, the script will make sure you have everything correctly installed.**

### Installation
1. Clone the repository:
   
   ```sh
   git clone https://github.com/Warbacon/zunder-zsh.git
   ```

2. Enter the cloned repository and run the `install.sh` script:
   
   ```sh
   cd ./zunder-zsh
   ./install.sh
   ```

And everything should be ready.

## 🖌️ Customizing zunder-zsh
You can add custom configurations to zunder-zsh in `~/.config/zsh/user-config.zsh`
to make sure that is not overwritten if you update zunder-zsh.

Here are some additional settings you can add:

### Customize fzf theme
Maybe bothers you that the colorscheme of `fzf` is diferent from the theme
you set in your terminal. The `fzf` theme can be changed, so you might want to do that.

Here is a example changing the colorscheme to Catppuccin Mocha:

```zsh
export FZF_DEFAULT_OPTS=" \
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
```

All the Catppuccin presets are in [catppuccin/fzf](https://github.com/catppuccin/fzf).

You can see more in [tinted-theming/base16-fzf](https://github.com/tinted-theming/base16-fzf/tree/main/bash).
Sourcing one of them should do the work:

```zsh
source "$ZDOTDIR/your-theme.config"
```

### Changing LS_COLORS
The variable called `LS_COLORS` controls the colors the output of some programs will have.
The easiest method to set a custom colors is installing [vivid](https://github.com/sharkdp/vivid).

You can install it in any system using by putting this code in your `user-config.zsh` file:

```zsh
zi ice from"gh-r" as"program" pick'vivid*/vivid'
zi light "sharkdp/vivid"
```

To see all available themes, you can use the `vivid themes` command and then
set one in your `user-config.zsh` using:

```zsh
export LS_COLORS=$(vivid generate your-theme)
```

Replacing `your-theme` with your prefered theme.

### Installing fnm
`fnm` is a node version manager written in Rust and built with speed in mind.
You can see more information [here](https://github.com/Schniz/fnm).

You can install and load it at maximum speed using this code:
```zsh
# FNM
FNM_DIR="$HOME/.local/share/fnm"
export PATH="$PATH:$FNM_DIR"

# Install fnm
[ ! -d "$FNM_DIR" ] && \
    curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell

# Install completions for fnm
[ ! -f "$FNM_DIR/_fnm" ] && fnm completions > "$FNM_DIR/_fnm"
zi ice as"completion"
zi snippet "$FNM_DIR/_fnm"

# Load fnm
zi ice atload"ZSH_EVALCACHE_DIR=\"$ZDOTDIR/.zsh-evalcache\";
    _evalcache fnm env --use-on-cd"
zi light "mroth/evalcache"
```

## 🔧 Troubleshooting
Zunder-zsh is under constant development, so errors may occur. I suggest you open an issue and **I'll help you as fast as I can**. 
Anyway, if you didn't like it or want to go back to your previous configuration, you can run the ``uninstall.sh`` script located in this same repository:

```bash
./uninstall.sh
```

Additionally, if you used previously another shell, you can revert it using the following command:

```bash
sudo usermod -s $(which bash) $USER
```
You can change bash for the shell of your choice.

### Man command highlighting as error in Arch Linux
Just run these commands if you are using `man-db` (most likely):

```bash
sudo mandb
sudo systemctl enable man-db.timer
```

More info [here](https://github.com/zdharma-continuum/fast-syntax-highlighting/issues/35#issuecomment-1315195049).

## 📃 Extra info
Zunder is in very active development and it's constantly evolving,
so you should check the project frequently to find out the latest news.
**I appreciate that bugs are reported and new ideas are suggested.** 
