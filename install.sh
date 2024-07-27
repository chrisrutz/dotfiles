#!/bin/bash

echo "Setting up your Mac..."

set -e

print_message()  {
  echo "$1..."
}

prompt_override() {
  local file=$1
  if [ -f "$file" ]; then
    read -p "$file already exists. Do you want to override it? (y/n): " choice
    if [ "$choice" != "y" ]; then
      mv "$file" "${file}.bak"
      echo "Backup of $file created as ${file}.bak"
    fi
  fi
}

print_message "Prompt for sudo password"
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

print_message "Make ZSH the default shell environment"
sudo chsh -s $(which zsh)

print_message "Install Xcode Command Line Tools"
if ! xcode-select -p &> /dev/null; then
xcode-select --install &> /dev/null

  until xcode-select -p &> /dev/null; do
    sleep 5
  done

  sudo xcodebuild -license
fi

print_message "Check Homebrew installation"
if ! command -v brew >/dev/null 2>&1; then
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

print_message "Update Homebrew formulae"
brew update && brew upgrade

print_message "Install Brewfile bundle"
brew tap homebrew/bundle
brew bundle
prompt_override ~/.Brewfile && cp Brewfile ~/.Brewfile

print_message "Install Oh My Zsh"
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
print_message "Install iTerm2 shell integration"
bash -c "$(curl -L https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh)"
print_message "Install NVM"
bash -c "$(curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh)"

print_message "Install latest ruby version using rbenv"
eval "$(rbenv init -)"
latest_ruby=$(rbenv install -l | grep -v - | tail -1)
rbenv install $latest_ruby
rbenv global $latest_ruby

print_message "Copy dotfiles"
for file in .{gemrc,irbrc,pryrc,zshrc,gitconfig,gitignore_global}; do
  prompt_override ~/$file && cp $file ~/$file
done

print_message "Authenticate with GitHub"
gh auth login
git config --global user.name "$(gh api user --jq '.name')"
git config --global user.email "$(gh api user --jq '.email')"

print_message "Source zshrc"
source ~/.zshrc

print_message "Install Ruby gems"
gem install pry bundler bundle_update_interactive

print_message "Install Node.js"
nvm install --lts
nvm alias default lts/*

# Set macOS preferences
# We will run this last because this will reload the shell
# source .macos

echo "Done."
