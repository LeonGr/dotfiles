# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="refined"

plugins=(git z thefuck)
fpath+=("/Users/Leon/.oh-my-zsh/functions")
eval $(thefuck --alias)

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
alias dockerStart='source /Applications/Docker/Docker\ Quickstart\ Terminal.app/Contents/Resources/Scripts/start.sh'
alias ack='ack-grep'
alias msfconsole="./msfconsole --quiet -x \"db_connect ${USER}@msf\""
alias p='xclip -o'
#openFunction(){
    #xdg-open $1
    #sleep 1
#}
#alias open=openFunction
alias music='echo "Song: " && playerctl metadata "xesam:title" && echo "\nAlbum: " && playerctl metadata "xesam:album" && echo "\nArtist: " && playerctl metadata "xesam:albumArtist"'
alias exuent='exit'
alias spotify='spotify --force-device-scale-factor=1.5'

export CLICOLOR=1
export TERM=xterm-256color

export SUDO_EDITOR=/usr/bin/nvim

PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'
source ~/dotfiles/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

#test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh

autoload -U promptinit; promptinit
prompt pure
export PURE_PROMPT_SYMBOL="$"

#cat ~/dotfiles/unix.txt
cat ~/dotfiles/motd/arch.txt

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
source ~/.rvm/scripts/rvm
PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"

LD_LIBRARY_PATH=/usr/local/lib
export LD_LIBRARY_PATH

export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
