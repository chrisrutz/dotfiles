# dotfiles

This repository contains my dotfiles. My apps and settings when setting up a new machine.

## Installation

On a fresh install of macOS, git is not installed by default.
Download this repository, and run the following commands:

```bash
curl -LJO https://github.com/chrisrutz/dotfiles/archive/refs/heads/master.zip
unzip -q dotfiles-master.zip
mv dotfiles-master ~/.dotfiles
rm dotfiles-master.zip
cd ~/.dotfiles
sh install.sh
```

The install script will do the following:
- change the default shell to ZSH
- install Xcode Command Line Tools
- install [Homebrew](https://brew.sh/)
- Homebrew packages, casks, and Visual Studio Code Extensions via [Homebrew Bundle](https://github.com/Homebrew/homebrew-bundle) (see [Brewfile](Brewfile))
- install [Oh My Zsh](https://ohmyz.sh/)
- install [iTerm2 shell integration](https://iterm2.com/documentation-shell-integration.html)
- install [NVM](https://github.com/nvm-sh/nvm)
- install the latest ruby version using [rbenv](https://rbenv.org/)
- copy dotfiles to home directory
- copy Visual Studio Code personal [profile](https://code.visualstudio.com/docs/editor/profiles)
- authenticate with GitHub using GitHub CLI
- install some default gems
- configure MacOS default settings

After finishing the installation, restart the system.

## MacOS default settings

The script will set the following MacOS default settings:


