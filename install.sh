#!/bin/sh

FMT_RED=$(printf "\033[31m")
FMT_GREEN=$(printf "\033[32m")
FMT_YELLOW=$(printf "\033[33m")
FMT_BLUE=$(printf "\033[34m")
FMT_CYAN=$(printf "\033[36m")
FMT_BOLD=$(printf "\033[1m")
FMT_RESET=$(printf "\033[0m")

ZDOTDIR="$HOME/.config/zsh"

set -e

command_exists() {
  command -v "$@" >/dev/null 2>&1
}

fmt_error() {
  printf "%sError: %s%s\n" "${FMT_BOLD}${FMT_RED}" "$*" "$FMT_RESET" >&2
}

fmt_warning() {
  printf "%s%s%s\n" "${FMT_BOLD}${FMT_YELLOW}" "$*" "$FMT_RESET"
}

fmt_success() {
  printf "%s%s%s\n" "$FMT_GREEN" "$*" "$FMT_RESET"
}

fmt_info() {
  printf "%s:: %s%s%s\n" "${FMT_BOLD}${FMT_CYAN}" "${FMT_RESET}${FMT_BOLD}" "$*" "$FMT_RESET"
}

fmt_prompt() {
  printf "%s:: %s%s%s" "${FMT_BOLD}${FMT_BLUE}" "${FMT_RESET}${FMT_BOLD}" "$*" "$FMT_RESET"
}

print_line() {
  printf "%*s\n" "$(stty size | cut -d ' ' -f2)" '' | tr ' ' '-'
}

user_can_sudo() {
  # Check if sudo is installed
  command_exists sudo || return 1
  # Termux can't run sudo, so we can detect it and exit the function early.
  [ "$os_type" = "android" ] && return 1
  # The following command has 3 parts:
  #
  # 1. Run `sudo` with `-v`. Does the following:
  #    • with privilege: asks for a password immediately.
  #    • without privilege: exits with error code 1 and prints the message:
  #      Sorry, user <username> may not run sudo on <hostname>
  #
  # 2. Pass `-n` to `sudo` to tell it to not ask for a password. If the
  #    password is not required, the command will finish with exit code 0.
  #    If one is required, sudo will exit with error code 1 and print the
  #    message:
  #    sudo: a password is required
  #
  # 3. Check for the words "may not run sudo" in the output to really tell
  #    whether the user has privileges or not. For that we have to make sure
  #    to run `sudo` in the default locale (with `LANG=`) so that the message
  #    stays consistent regardless of the user's locale.
  #
  ! LANG='' sudo -n -v 2>&1 | grep -q "may not run sudo"
}

install_icons() {
  fmt_info "Installing icons..."

  # Create directory if it does not exist
  mkdir -p "$HOME/.local/share/fonts"

  # Download font file
  curl -fLo "$HOME/.local/share/fonts/Symbols Nerd Font.ttf" \
    "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/NerdFontsSymbolsOnly/SymbolsNerdFont-Regular.ttf" \
    || return 1
}

install_package() {
  fmt_prompt "Do you want to install $*? [Y/n] "
  read -r response
  if [ "$response" != "n" ] && [ "$response" != "N" ]; then
    case $os_type in
      "arch") sudo pacman -S --noconfirm "$*" ;;
      "debian") sudo apt install -y "$*" ;;
      "fedora") sudo dnf install --assumeyes "$*" ;;
      "darwin") brew install "$*" ;;
      "android") pkg install -y "$*" ;;
      "void") sudo xbps-install -y "$*" ;;
      *)
        echo
        fmt_error "Zunder-zsh doesn't support automatic package installations" \
          "in your current operating system."
        echo "Please do it manually."
        exit 1
        ;;
    esac || {
      fmt_error "Installation failed."
      exit 1
    }
  else
    return 1
  fi
}

check_os_type() {
  if [ -f /etc/os-release ]; then
    os_type=$(grep "^ID_LIKE=" /etc/os-release | cut -d "=" -f 2 | tr -d '"')
    if [ -z "$os_type" ]; then
      os_type=$(grep "^ID=" /etc/os-release | cut -d "=" -f 2 | tr -d '"')
    fi
  else
    [ "$(uname)" = "Darwin" ] && os_type="darwin"
    case "$PREFIX" in
      *com.termux*) os_type="android" ;;
    esac
  fi
  case $os_type in
    "arch")
      fmt_info "You are using an arch-like distro."
      ;;
    "debian")
      fmt_info "You are using a debian-like distro."
      ;;
    "fedora")
      fmt_info "You are using a fedora-like distro."
      ;;
    "darwin")
      fmt_info "You are using MacOS."
      ;;
    "android")
      fmt_info "You are using termux on Android."
      ;;
    "void")
      fmt_info "You are using Void Linux."
      ;;
    *)
      fmt_warning "The type of your operating system could not be detected."
      echo "The functionality of the installer will be limited."
      echo
      fmt_prompt "Continue? [Y/n] "
      read -r response
      if [ "$response" = "n" ] || [ "$response" = "N" ]; then
        exit 1
      fi
      os_type="unknown"
      ;;
  esac
}

check_dependencies() {
  set -- "zsh" "unzip" "curl" "git"

  [ "$os_type" = "fedora" ] && set -- "$@" "sqlite"

  fmt_info "Checking dependencies..."

  for dependency in "$@"; do
    if ! command_exists "$dependency"; then

      [ "$dependency" = "sqlite" ] && dependency="sqlite3"

      if [ "$os_type" = "unknown" ]; then
        fmt_error "$dependency is needed for zunder-zsh to work properly."
        echo "Please install it manually."
        exit 1
      fi

      install_package "$dependency" || {
        fmt_error "$dependency is needed for zunder-zsh to work properly."
        echo "Please install it manually or run again this script."
        exit 1
      }
    fi

    shift 1

  done

  [ "$#" -eq 0 ] && fmt_success "All dependencies satisfied."
}

load_files() {
  printf "%s::%s Zunder-zsh will store its configuration in %s.\n" \
    "${FMT_BOLD}${FMT_CYAN}" "${FMT_RESET}${FMT_BOLD}" \
    "${FMT_CYAN}${ZDOTDIR}${FMT_RESET}"
  fmt_prompt "Continue? [y/N]: "
  read -r prompt

  echo
  if [ "$prompt" = "y" ] || [ "$prompt" = "Y" ]; then
    [ ! -d "$ZDOTDIR" ] && mkdir -vp "$ZDOTDIR"
    cp -v ./config/aliases.zsh "$ZDOTDIR"
    cp -v ./config/options.zsh "$ZDOTDIR"
    cp -v ./config/key-bindings.zsh "$ZDOTDIR"
    cp -v ./config/plugins.zsh "$ZDOTDIR"
    cp -v ./config/.zshrc "$ZDOTDIR"
    cp -v ./config/.zshenv "$HOME"
    [ -f "$HOME/.zsh_history" ] \
      && [ -f "$ZDOTDIR/.zsh_history" ] \
      && [ -n "$(find "$HOME/.zsh_history" -newer "$ZDOTDIR/.zsh_history")" ] \
      && mv -v "$HOME/.zsh_history" "$ZDOTDIR"
    [ ! -f "$ZDOTDIR/user-config.zsh" ] \
      && echo "# Write your configurations here" >"$ZDOTDIR/user-config.zsh"
    echo
    fmt_success "The configuration has been set up."
  else
    fmt_warning "Canceled. This won't apply your changes at all," \
      "try running the script again."
    exit 1
  fi
}

set_default() {
  if [ "$os_type" != "android" ]; then
    sudo usermod -s "$(which zsh)" "$USER"
  else
    chsh -s zsh
  fi
}

main() {
  check_os_type
  echo
  check_dependencies
  echo
  load_files
  if ! [ -d "$HOME/.local/share/zinit" ]; then
    echo
    fmt_info "Installing plugins..."
    zsh -i -c exit
  fi
  if [ "$os_type" != "darwin" ] && [ "$os_type" != "android" ] && [ "$os_type" != "unknown" ]; then
    fc-list | grep -q "Symbols Nerd Font" || (echo && install_icons)
  fi

  if [ "$(basename "$SHELL")" != "zsh" ]; then
    echo
    fmt_prompt "Zsh is not your current default shell, do you want to set it? [Y/n]: "
    read -r prompt

    if [ "$prompt" != "n" ] && [ "$prompt" != "N" ]; then
      if set_default >/dev/null 2>&1; then
        fmt_success "Zsh was applied as default shell."
        fmt_warning "You may have to restart your computer to apply the changes."
      else
        fmt_error "Zsh could not be applied as the default shell."
      fi
    else
      fmt_warning "Zsh won't be setted as the default shell."
    fi
  fi

  echo
  fmt_success "Installation complete."
}

main "$@"
