# dotfiles

This repository contains my dotfiles. My apps and settings when setting up a new machine.

## Installation

On a fresh install of macOS, git is not installed by default.
Download this repository, and run the following commands:

```bash
curl -LJO https://github.com/chrisrutz/dotfiles/archive/refs/heads/main.zip
unzip -q dotfiles-main.zip
mv dotfiles-main ~/.dotfiles
rm dotfiles-main.zip
cd ~/.dotfiles
bash install.sh
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
  - pry
  - rubocop
  - bundler
- configure [MacOS default settings](#macos-default-settings)

After finishing the installation, restart the system.

## MacOS default settings

The script will set the following MacOS default settings:

### UI/UX

- Ask to keep changes when closing documents
- Expand save panel by default
- Expand print panel by default
- Disable the "Are you sure you want to open this application?" dialog

### Dock

- Automatically hide and show the Dock
- Don't show recent applications in Dock
- Only show open applications in Dock (remove all apps from Dock)

### Screenshots

- Save screenshots to the desktop
- Save screenshots in PNG format
- Don't show thumbnail of screenshot after taking it

### Finder

- Show all filename extensions
- Show hidden files
- Show the status bar
- Show the path bar
- Set the default view style to list view
- Keep folders on top when sorting
- Set search scope to current folder
- Disable warning when changing a file extension
- Set Desktop as the default location for new Finder windows
- Avoid creating .DS_Store files on network volumes
- Avoid creating .DS_Store files on USB volumes
- Automatically open a new Finder window when a volume is mounted
- Empty Trash securely
- Disable the warning when emptying the Trash

### Desktop

- Keep folders on top when sorting
- Hide all desktop icons
- Hide external disks on the desktop
- Hide removable media on the desktop
- Don't reveal Desktop when clicking wallpaper

### Mouse and Trackpad

- Set mouse and trackpad speed
- Enable tap to click
- Enable two-finger right-click
- Swipe between pages with three fingers
- Swipe between full-screen apps with four fingers
- Mission Control with three-finger swipe up
- App Exposé with three-finger swipe down

### Keyboard

- Fn key opens emoji and symbols
- Disable auto-correct
- Disable smart quotes
- Disable smart dashes
- Disable automatic capitalization
- Disable automatic period substitution

### Battery

- show battery percentage in menu bar

### Control Center

- Show battery percentage in menu bar
- Don't show Siri in menu bar

### Mission Control

- Disable automatically rearrange Spaces based on most recent use
- Group windows by application

### iCloud

- Save to disk by default
- Allow Handoff between this Mac and your iCloud devices

### Time Machine

- Prevent Time Machine from prompting to use new hard drives as backup volume

### Security & Privacy

- Require password immediately after sleep or screen saver begins
- Enable FileVault

### Display & Screensaver

- Disable automatic adjustment of display brightness
- Start screensaver after 5 minutes of inactivity
