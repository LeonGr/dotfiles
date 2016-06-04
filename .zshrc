# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="sorin"

plugins=(git z thefuck)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.local/bin"

# Aliases
alias phpserver='php -S localhost:8000'
alias pythonserver='python -m "SimpleHTTPServer"'
alias py='python'
alias :wq='exit'
alias :q=':wq'
alias whatsapp='cd /home/leon/.config/UnofficialWhatsApp && rm -r Application\ Cache && rm -r Cache'
alias ack='ack-grep'
openFunction(){
    xdg-open $1
    sleep 1
}
alias open=openFunction

eval $(thefuck --alias)

export CLICOLOR=1
export TERM=xterm-256color

PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'
source ~/dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh
