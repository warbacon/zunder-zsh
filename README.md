# ⚡ Zunder-zsh

Zunder-zsh is a minimalistic zsh configuration with sane defaults.

![Preview](./assets/preview.gif)

## 🚩 Goals

- Straightforward transition from _bash_.
- Quick and **trouble-free** installation.
- Responsive typing.
- Fastest possible startup time without sacrificing functionality.
- Provide **only completely necessary functionality** and be **easy to
  extend**.

## 💡 Features

- Syntax highlighting and autosuggestions.
- Automatic installation.
- Sensible keybindings.
- Smarter completions.
- [Exa](https://github.com/eza-community/eza) integration.
- Extra fast and minimalistic integrated plugin manager. See
  [Zap](https://github.com/zap-zsh/zap).

### Plugins

- [spaceship-prompt](https://spaceship-prompt.sh) - Minimalistic, powerful and
  extremely customizable Zsh prompt. I provide a configuration file to make it
  more performant and less noisy.
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) -
  Fish shell like syntax highlighting for Zsh.
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) -
  Fish-like fast/unobtrusive autosuggestions for Zsh.
- [zsh-completions](https://github.com/zsh-users/zsh-completions) - Additional
  completion definitions for Zsh.
- [command-not-found](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/command-not-found)
  plugin from Oh My Zsh - Provide suggested packages to be installed if a
  command cannot be found.

> [!NOTE]
> I provide a `plug-defer` function to Zap to defer loading of heavy plugins
> and improve startup times. It uses [romkatv's
> zsh-defer](https://github.com/romkatv/zsh-defer).

### Aliases

| Alias | Description                                                                |
| ----- | -------------------------------------------------------------------------- |
| ll    | Long list directory contents. Uses exa if installed.                       |
| la    | List directory contents with hidden files. Uses exa if installed.          |
| lla   | Long list directory contents with hidden files. Uses exa if installed.     |
| lt    | Displays the directory tree in the current directory. Uses `tree` or `exa`.|

## 🤔 Why should I use it?

Zunder-zsh has been designed so that any user can use it almost instantly
without having to learn new things, just run the script and you are ready to
go. There are no unnecessary things and everything works fast.

### Zunder-zsh vs Oh My Zsh

Oh My Zsh is a framework, **zunder-zsh isn't**. This means that while Oh My Zsh
requires you to configure your shell how they want, zunder-zsh doesn't, since
its level of abstraction is very low, making it so that anyone can understand
what is happening behind the scenes and can be modified in the way you prefer.

That means that zunder-zsh doesn't support updates, as is designed so that any
user can modify the configuration as desired. However, if you are a user who
makes very few modifications, you can use a method to upgrade directly without
losing your custom settings. See [File
Structure](https://github.com/warbacon/zunder-zsh?tab=readme-ov-file#-file-structure).

## 💊 Compatibility

Although zunder-zsh can run on any POSIX-compliant operating system, the
installation script will have more functionality on the following operating
systems:

- Arch Linux and derivatives (EndeavourOS, Manjaro, etc.).
- Debian and derivatives (Ubuntu, Linux Mint, etc.).
- Fedora and derivatives (NobaraOS, Ultramarine Linux, etc.).
- OpenSUSE and derivatives (Tumbleweed, Leap, GeckoLinux, etc.).
- Void Linux.
- MacOS.
- Android (using [termux](https://termux.dev)).

**Works also in wsl**, but syntax highlighting will be disabled because it
produces input lag when typing.

## 🚀 Getting started

### Nerd fonts

Depending on your operating system, the required icons will be installed if
needed, but may require additional configuration.

If you don't see the icons correctly and don't want to complicate your life,
you can install a [Nerd Font](https://www.nerdfonts.com/) and set it as default
on your terminal.

> I recommend JetBrainsMono Nerd Font

You can use
[Termux:Styling](https://f-droid.org/es/packages/com.termux.styling) on Android
and set as font, for example, Fira Code.

### Installation

1. Clone this repository locally:

    ```sh
    git clone https://github.com/warbacon/zunder-zsh.git
    ```

2. Enter the cloned repository and run the install script:

    ```sh
    cd ./zunder-zsh
    ./install.sh
    ```

## 📁 File Structure

<pre>
~
├──/.zsh_history  <- zsh history
├──/.zshenv       <- environment variables
├──/.zshrc        <- main configuration
│
├──/.config/zunder-zsh
│           ├── spaceship.zsh   <- spaceship config
│           ├── after.zsh       <- loads after main config
│           ├── before.zsh      <- loads before main config
│           └──/functions       <- extra useful functions
│               └── ...
│
├──/.cache/zsh
│          ├── .zcompdump       <- completions cache
│          └── .zcompdump.zwc   <- compiled version
│
└──/.local/share/zap          <- installed plugins
                 └── ...
</pre>

The `~/.config/zunder-zsh` directory and its files are not created
automatically. They are intended to extend zunder-zsh easily without modifying
the main configuration.

- `before.zsh` loads after the Zap initialization but before all the main
  configuration. Here, you should write additional plugins you want to add and
  zunder-zsh specific options.

- `after.zsh` loads after all the main configuration. Here, you should write
  all your additional configurations.

## 🎨 Customizing zunder-zsh

### Zunder-zsh specific options

> [!IMPORTANT]
> These variables must be set in your `before.zsh`!

Usage:

```sh
# ~/.config/zunder-zsh/before.zsh

DISABLE_AUTOSUGGESTIONS=true    # zsh-autosuggestions will be disabled
```

| Variable                     | Description                                      | Default value          |
| ---------------------------- | ------------------------------------------------ | ---------------------- |
| DISABLE_AUTOSUGGESTIONS      | Disables zsh-autosuggestions.                    | "" (true in Linux tty) |
| DISABLE_SPACESHIP_PROMPT     | Disables spaceship-prompt.                       | ""                     |
| DISABLE_EXA                  | Disables exa/eza integration.                    | ""                     |
| SYNTAX_HIGHLIGHTING_PROVIDER | Changes the plugin used for syntax highlighting  | "" ("none" in WSL)     |

> [!NOTE]
> Allowed values for `SYNTAX_HIGHLIGHTING_PROVIDER`:
> `zsh-syntax-hightlighting`, `fast-syntax-highlighting` and `none`.

### Exa integration

Zunder-zsh will enable exa integration automatically if `exa` is installed.
**You must install `exa` or `eza` manually** for this to happen. You can force
it to be disabled by setting `DISABLE_EXA` to `true` in your `before.zsh`.

### Fzf integration

> [!IMPORTANT]
> You need to install `fzf` manually

```bash
[[ -n "$commands[fzf]" ]] && eval "$(fzf --zsh)"
```

This enables the integration of fzf into zsh, making it possible to use the
following keybindings:

| Keybinding | Description                                   |
| ---------- | --------------------------------------------- |
| Ctrl+r     | Search history of shell commands.             |
| Ctrl+t     | List files and folders in current directory.  |
| Alt+c      | Fuzzy change directory.                       |

## 🔧 Troubleshooting

**If you find any error in zunder-zsh, I would appreciate if you open an issue
and I will try to help you as soon as possible.**

If you didn't like it or want to go back to your previous configuration, you
can run the `uninstall.sh` script located in this same repository:

```sh
./uninstall.sh
```

Additionally, if you used previously another shell, you can revert it using the
following command:

```sh
sudo usermod -s $(which bash) $USER
```

You can change bash for the shell of your choice.

## 🤝 I need you

If you encounter any issue or have any suggestions, please don't hesitate to
contact me. I'm open to any discussion and **I'll be happy to help!**
