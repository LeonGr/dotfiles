# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="refined"

plugins=(git z)
fpath+=("/Users/Leon/.oh-my-zsh/functions")
#eval $(thefuck --alias)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.local/bin"

# Aliases
alias phpserver='php -S localhost:8000'
alias pythonserver='python -m "SimpleHTTPServer"'
alias py='python'
alias :wq='exit'
alias :q=':wq'
alias ack='ack-grep'
alias msfconsole="./opt/metasploit/msfconsole --quiet -x \"db_connect ${USER}@msf\""
alias p='xclip -o'
alias music='echo "Song: " && playerctl metadata "xesam:title" && echo "\nAlbum: " && playerctl metadata "xesam:album" && echo "\nArtist: " && playerctl metadata "xesam:albumArtist"'
alias exuent='exit'
alias spotify='spotify --force-device-scale-factor=1.5'
alias vis='TERM=rxvt-256color vis'

alias status='sudo systemctl status'
alias stop='sudo systemctl stop'
alias start='sudo systemctl start'
alias restart='sudo systemctl restart'

# ls -> exa
alias ls='exa'
alias ll='exa -l'
alias la='exa -la'
alias lt='exa -T'
alias lr='exa -R'
alias lat='exa -laT'
alias lar='exa -laR'

function getip {
     host $1 | awk '{print $4}' | sed -n '1p';
}

export getip

export CLICOLOR=1
export TERM=xterm-256color

export SUDO_EDITOR=/usr/bin/nvim

PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'
source ~/dotfiles/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

#test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh

autoload -U promptinit; promptinit
prompt pure
export PURE_PROMPT_SYMBOL="❯"

#cat ~/dotfiles/unix.txt
#cat ~/dotfiles/motd/arch.txt #| lolcat -F 0.5
cat ~/dotfiles/motd/aperture.txt

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
source ~/.rvm/scripts/rvm
PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"

LD_LIBRARY_PATH=/usr/local/lib
export LD_LIBRARY_PATH

export LC_ALL=en_US.utf-8 export LANG=en_US.utf-8

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# old anaconda
#export PATH="/home/leon/anaconda3/bin:$PATH"
export PATH="$JAVA_HOME/bin:$PATH"

(cat ~/.cache/wal/sequences &)

# Import colorscheme from 'wal'
(cat /home/leon/.cache/wal/sequences)

# Give man colors
export MANROFFOPT='-c'
export LESS_TERMCAP_mb=$(tput bold; tput setaf 1)
export LESS_TERMCAP_md=$(tput bold; tput setaf 6)
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4)
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7)
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)

[[ -s "/etc/grc.zsh" ]] && source /etc/grc.zsh

export ANDROID_SDK_ROOT='/home/leon/Android/Sdk/'
#export ANDROID_SDK_HOME='/home/leon/.android/'
export ANDROID_SDK_HOME='/home/leon/Android/Sdk/'
#export ANDROID_HOME='/home/leon/Android/Sdk/'
export ANDROID_AVD_HOME='/home/leon/.android/avd/'
. /home/leon/anaconda3/etc/profile.d/conda.sh
