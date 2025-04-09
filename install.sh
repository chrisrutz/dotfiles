#!/bin/bash

# Redirect stdout and stderr to a log file in append mode
exec >> >(tee -a .install.log)
exec 2>&1

set -e

BACKUP_TIMESTAMP=$(date +%s)

print_message()  {
  echo "$1"
}

prompt_override() {
  local target=$1
  local backup_dir="$HOME/.dotfiles.backup"

  if [ ! -d "$backup_dir" ]; then
    mkdir -p "$backup_dir"
  fi

  if [ -e "$target" ]; then
    read -p "$target already exists. Do you want to override it? (y/n): " choice
    case "$choice" in
      y|Y )
        mv "$target" "$backup_dir/$(basename "$target").$BACKUP_TIMESTAMP"
        return 0
        ;;
      n|N )
        return 1
        ;;
      * )
        echo "Invalid choice. Skipping."
        return 1
        ;;
    esac
  else
    return 0
  fi
}

check_macos() {
  if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "Abort. This script is intended to be run on macOS."
    exit 1
  fi
}

setup_sudo() {
  print_message "Prompt for sudo password"
  sudo -v
  while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
}

set_default_shell() {
  print_message "Make ZSH the default shell environment"
  sudo chsh -s $(which zsh)
}

install_xcode_command_line_tools() {
  if ! xcode-select -p &> /dev/null; then
    print_message "Install Xcode Command Line Tools"
    xcode-select --install &> /dev/null

    until xcode-select -p &> /dev/null; do
      sleep 5
    done
  else
    print_message "Xcode Command Line Tools are already installed"
  fi
}

install_homebrew() {
  if ! command -v brew >/dev/null 2>&1; then
    print_message "Install Homebrew"
    NONINTERACTIVE=1 bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    touch "$HOME/.zprofile"
    (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> "$HOME/.zprofile"
    eval "$(/opt/homebrew/bin/brew shellenv)"
    chmod -R go-w "$(brew --prefix)/share"
  else
    print_message "Homebrew is already installed, Updating Homebrew and installed formulae"
    brew update && brew upgrade
  fi
  prompt_override "$HOME/.homebrew/brew.env" && {
    mkdir -p "$HOME/.homebrew"
    cp .homebrew/brew.env "$HOME/.homebrew/brew.env"
  }
}

install_homebrew_bundle() {
  print_message "Install Brewfile bundle"
  brew bundle --no-lock --no-upgrade
  prompt_override "$HOME/Brewfile" && cp Brewfile "$HOME/Brewfile"

  brew cleanup
}

install_oh_my_zsh() {
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    print_message "Install Oh My Zsh"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  fi
}

install_iterm2_shell_integration() {
  print_message "Install iTerm2 shell integration"
  curl -L https://iterm2.com/shell_integration/zsh -o "$HOME/.iterm2_shell_integration.zsh"
  source "$HOME/.iterm2_shell_integration.zsh"
}

install_nvm() {
  print_message "Install or Update NVM"
  bash -c "$(curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh)"

  export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
}

install_node() {
  print_message "Install Node.js"
  nvm install node
  nvm alias default node
}

install_ruby() {
  eval "$(rbenv init -)"
  latest_ruby=$(rbenv install -l | grep -v - | tail -1)
  if [ $(rbenv version-name) != $latest_ruby ]; then
    print_message "Install latest ruby version using rbenv"
    rbenv install $latest_ruby
    rbenv global $latest_ruby
  else
    print_message "Latest ruby version is already installed"
  fi
}

copy_dotfiles() {
  print_message "Copy dotfiles"
  for file in .{gemrc,irbrc,pryrc,zshrc,gitconfig,gitignore_global}; do
    prompt_override "$HOME/$file" && cp $file "$HOME/$file"
  done
}

# copy_vscode_profile() {
#   print_message "Copy Visual Studio Code Profile"
#   prompt_override "$HOME/Library/Application\ Support/Code/User/profiles/chrisrutz.code-profile" && cp chrisrutz.code-profile "$HOME/Library/Application\ Support/Code/User/profiles"
# }

authenticate_with_github() {
  if ! gh auth status &> /dev/null; then
    print_message "Authenticate with GitHub"
    gh auth login
  else
    print_message "Already authenticated with GitHub"
  fi
  git config --global user.name "$(gh api user --jq '.name')"
  git config --global user.email "$(gh api user --jq '.email')"
}

install_global_gems() {
  print_message "Install global Ruby gems"
  gem install rubocop solargraph pry bundler bundle_update_interactive
}

configure_macos_preferences() {
  print_message "Configure macOS preferences"
  source .macos
}

main() {
  print_message "Setting up your Mac..."
  print_message "This script will run a series of commands to set up your Mac just the way I like it."
  print_message "Please review the script before running it."
  check_macos
  setup_sudo
  set_default_shell
  # install_xcode_command_line_tools # can be skipped as Xcode Command Line Tools are installed with Homebrew
  install_homebrew
  install_homebrew_bundle
  install_oh_my_zsh
  install_iterm2_shell_integration
  install_nvm
  install_node
  install_ruby
  copy_dotfiles
  # copy_vscode_profile # disabled as profiles are synced with github
  authenticate_with_github
  install_global_gems
  configure_macos_preferences

  print_message "Done."
}

main "$@"
