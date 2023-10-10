# ⚡ Zunder-zsh

Zunder-zsh is a minimalistic zsh configuration with sane defaults.

![Preview](./assets/preview.gif)

## 💡Features

- There is no magic here. Zunder-zsh isn't a framework and tries to be clear
about how it works.
- Beautiful, clean and lag free prompt with git support.
See [zunder-prompt](https://github.com/Warbacon/zunder-prompt).
- Almost instant start-up.
- Syntax highlightling and autosuggestions.
- [Exa](https://github.com/eza-community/eza) integration.
- Automatic installation.

### Plugins

- [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting) -
Feature rich and fast syntax highlighting for zsh.
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) -
Fish-like fast/unobtrusive autosuggestions for zsh.
- [zsh-completions](https://github.com/zsh-users/zsh-completions) -
Additional completion definitions for zsh.
- [zsh-lscolors](https://github.com/Warbacon/zsh-lscolors) -
My own plugin to set the ls_colors variable to those of the terminal
and display them in the completions.
- [command-not-found](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/command-not-found)
plugin from Oh My Zsh - Provide suggested packages to be installed if a command cannot be found.
- [sudo](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo) plugin from Oh My Zsh -
Easily prefix your current or previous commands with sudo by pressing ALT+S.

### Aliases

| Alias | Description                                                                  |
| ----- | ---------------------------------------------------------------------------- |
| ll    | Long list directory contents. Uses exa if installed.                         |
| la    | List directory contents with hidden files. Uses exa if installed.            |
| lla   | Long list directory contents with hidden files. Uses exa if installed.       |
| lt    | Displays the directory tree in the current directory. Uses exa if installed. |

## 🤔 Why should I use it?

Zunder-zsh has been designed so that any user can use it almost instantly
without having to learn new things, just run the script and you are ready to go.
Here there are no unnecessary things and everything works fast.

**However**, if you are a more advanced user, you may need to extend zunder-zsh
more than usual, thus making the configuration more complicated than if you were
not using zunder-zsh. If this happens to you, I recommend that you create your
own configuration, either by forking this project or creating it from scratch.

### Zunder-zsh vs Oh My Zsh

Oh My Zsh is a framework, **zunder-zsh is not**. This means that while Oh My Zsh
requires you to configure your shell how they want, zunder-zsh does not,
since its level of abstraction is very low, making it so that anyone can
understand what is happening behind the scenes and can be modified in the way
you prefer.

## 💊 Compatibility

Although zunder-zsh can run on any POSIX-compliant operating system,
the installation script will have more functionality on
the following operating systems:

- Arch Linux and derivatives (EndeavourOS, Manjaro, etc.).
- Debian and derivatives (Ubuntu, Linux Mint, etc.).
- Fedora and derivatives (NobaraOS, Ultramarine Linux, etc.).
- Void Linux.
- MacOS.
- Android (using [termux](https://termux.dev)).

**Works also in wsl**, but syntax highlighting will be disabled
because it produces input lag when typing.

## 🚀 Getting started

### Nerd fonts

Depending on your operating system, the necessary icons will be installed
if needed, but may require additional configuration. 

If you do not see the icons correctly and do not want to complicate your life,
you can install a [Nerd Font](https://www.nerdfonts.com/)
and set it as default on your terminal.

You can use [Termux:Styling](https://f-droid.org/es/packages/com.termux.styling)
and set as font Fira Code.

> I recommend JetBrainsMono Nerd Font

### Installation

1. Clone this repository locally:

```sh
git clone https://github.com/Warbacon/zunder-zsh.git
```

2. Enter the cloned repository and run the install script.

```sh
cd ./zunder-zsh
./install.sh
```

## 🖌️ Customizing zunder-zsh

You can add custom configurations to zunder-zsh in 
`~/.config/zsh/user-config.zsh` to make sure that it's not overwritten
if you update zunder-zsh.

Here are some additional settings you can add:

### Disable autosuggestions

```sh
ZSH_AUTOSUGGEST_STRATEGY=()
```

### Change the symbol and its color in the prompt's character

Zunder-zsh uses [zunder-prompt](https://github.com/Warbacon/zunder-prompt) as
its prompt. To customize its symbol and color, you can modify
the following environment variables:

```sh
ZUNDER_PROMPT_CHAR="❯"             # default value: ""
ZUNDER_PROMPT_CHAR_COLOR="green"   # default value: 3 ("yellow")
```

`ZUNDER_PROMPT_CHAR_COLOR` does accept any color between 0 and 255
or a color name.

## 🔧 Troubleshooting

**If you find any error in zunder-zsh, I would appreciate if you open an issue
and I will try to help you as soon as possible.**

If you didn't like it or want to go back to your previous configuration,
you can run the ``uninstall.sh`` script located in this same repository:

```sh
./uninstall.sh
```

Additionally, if you used previously another shell, you can revert it using the following command:

```sh
sudo usermod -s $(which bash) $USER
```

You can change bash for the shell of your choice.

### Man command highlighting as error in Arch Linux

Info [here](https://github.com/zdharma-continuum/fast-syntax-highlighting/issues/35#issuecomment-1315195049).

## 🫵 I need you

If you encounter any issue or have any suggestions, please do not hesitate
to contact me. I'm open to any discussion and **I'll be happy to help!**

