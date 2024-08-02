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

The install script will install the following:
- Xcode Command Line Tools
- Homebrew
- Homebrew packages and casks (see Brewfile)
- Oh My Zsh
- Oh My Zsh plugins
- iTerm2 shell integration
- NVM
- the latest ruby version using rbenv
- copy dotfiles to home directory
- authenticate with GitHub using GitHub CLI
- some default gems
- MacOS default settings

## MacOS default settings

The script will set the following MacOS default settings:


