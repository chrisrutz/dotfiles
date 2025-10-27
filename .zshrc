export ZSH="$HOME/.oh-my-zsh"

# name of the theme to load
# ZSH_THEME="ys" # disabled, because using spaceship theme

# auto-update behavior
zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' frequency 7
zstyle ':omz:update' verbose silent # limit the update verbosity to only errors

# display red dots whilst waiting for completion
COMPLETION_WAITING_DOTS="true"

# plugins to load
plugins=(git gh ruby rails golang python brew rbenv gem bundler z macos vscode aliases alias-finder nvm)

zstyle ':omz:plugins:nvm' autoload yes
zstyle ':omz:plugins:nvm' silent-autoload yes

source $ZSH/oh-my-zsh.sh

# User configuration

# source project specific configuration
function chpwd() {
  if [ -r $PWD/.zsh_config ]; then
    source $PWD/.zsh_config
  fi
}

# ssh
export SSH_KEY_PATH="~/.ssh/id_rsa"

# personal aliases
alias brewup='bubu; brew doctor'

zstyle ':omz:plugins:alias-finder' autoload yes
zstyle ':omz:plugins:alias-finder' cheaper yes

if command -v brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit

  source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
test -e "$(brew --prefix)/opt/spaceship/spaceship.zsh" && source "$(brew --prefix)/opt/spaceship/spaceship.zsh"

if command -v rbenv &>/dev/null; then
  eval "$(rbenv init - zsh)"
fi
if command -v ngrok &>/dev/null; then
  eval "$(ngrok completion)"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
