# ⚡ Zunder-zsh

**Zunder-zsh** is a zsh configuration designed to make your terminal experience amazing.

![example](./assets/preview.gif)

## 🪧 Features

- Clean and lightning-fast.
- Autosuggestions and syntax highlighting.
- Beautiful and lightweight prompt based on [gitstatus](https://github.com/romkatv/gitstatus).
Check out [zunder-prompt](https://github.com/Warbacon/zunder-prompt).
- Replaces the `ls` command with [exa](https://github.com/ogham/exa) (if is installed).
- Full [Git](https://git-scm.com/) integration.
- Compatible with all [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh) plugins
thanks to [zinit](https://github.com/zdharma-continuum/zinit).
- See [Installed plugins](https://github.com/Warbacon/zunder-zsh#installed-plugins).

### Essential aliases

| Alias | Command                                         |
| ----- | ----------------------------------------------- |
| ll    | Long list directory contents                    |
| la    | List directory contents with hidden files       |
| lla   | Long list directory contents with hidden files  |

### Installed plugins

- [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting) -
Feature rich and fast syntax highlighting for zsh.
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) -
Fish-like fast/unobtrusive autosuggestions for zsh.
- [zsh-completions](https://github.com/zsh-users/zsh-completions) -
Additional completion definitions for zsh.
- [zsh-lscolors](https://github.com/Warbacon/zsh-lscolors) -
My own plugin to set the ls_colors variable to those of the terminal
and display them in the completions.
- [sudo](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo) plugin from Oh My Zsh -
Easily prefix your current or previous commands with sudo by pressing ALT+S.
- [command-not-found](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/command-not-found)
plugin from Oh My Zsh - Provide suggested packages to be installed if a command cannot be found.

### Supported operating systems

- Arch Linux and derivatives (Manjaro, Endeavour OS...).
- Debian/Ubuntu and derivatives (Pop OS, Kubuntu, Linux Mint...).
- Fedora and derivatives (Ultramarine Linux, Nobara...).
- Void Linux.
- Mac OS.
- Android (using [Termux](https://termux.com/)).

Might support more in the future, depending on requests.

## 🚀 Getting started

### Dependencies

Although icons will be installed automatically, it's **recommended to install
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
to make sure that it's not overwritten if you update zunder-zsh.

Here are some additional settings you can add:

### Change the symbol and its color in the prompt's character

Zunder-zsh uses [zunder-prompt](https://github.com/Warbacon/zunder-prompt) as
its prompt. To customize its symbol and color, you can modify
the following environment variables:

```bash
ZUNDER_PROMPT_CHAR="❯"             # default value: ""
ZUNDER_PROMPT_CHAR_COLOR="green"   # default value: 3 ("yellow")
```

`ZUNDER_PROMPT_CHAR_COLOR` does accept any color between 0 and 255
or a color name.

### Customize fzf theme

Maybe bothers you that the colorscheme of `fzf` is different from the theme
you set in your terminal. The `fzf` theme can be changed so you might want to do that.

Here is an example changing the colorscheme to Catppuccin Mocha:

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
