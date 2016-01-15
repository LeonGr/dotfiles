# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="leon"

plugins=(git z thefuck)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.local/bin"

# Aliases
alias phpserver='php -S localhost:8000'
alias pythonserver='Python -m "SimpleHTTPServer"'
alias vim='nvim'
alias py='python'

eval $(thefuck --alias)
source ~/dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
