# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME=""

plugins=(git z zsh-autosuggestions)
fpath+=("/home/leon/.oh-my-zsh/functions")

source $ZSH/oh-my-zsh.sh

# User configuration
export HISTSIZE=100000

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.local/bin"

# Aliases
alias phpserver='php -S localhost:8000'
alias pythonserver='python -m http.server'
alias py='python'
alias :wq='exit'
alias :q='exit'
alias ack='ack-grep'
alias msfconsole="/opt/metasploit/msfconsole -x \"db_connect ${USER}@msf\""
alias p='xclip -o'
alias music='echo "Song: " && playerctl metadata "xesam:title" && echo "\nAlbum: " && playerctl metadata "xesam:album" && echo "\nArtist: " && playerctl metadata "xesam:albumArtist"'
alias exuent='exit'
alias spotify='spotify --force-device-scale-factor=1.5'
alias rofi-emoji='rofi -show emoji -modi emoji'
alias status='sudo systemctl status'
alias stop='sudo systemctl stop'
alias start='sudo systemctl start'
alias restart='sudo systemctl restart'
alias sus='systemctl suspend'
alias aurfind="paru -Slq | fzf -m --preview 'cat <(paru -Si {1}) <(paru -Fl {1} | awk \"{print \$2}\")' | xargs -ro  paru -S"
alias tmux='TERM=xterm-256color tmux' # make cursor work
alias mv='mv -i' # (--interactive) confirm overwrites
alias scrot="scrot --exec 'xclip -selection clipboard -target image/png -in \$f'"

# ls -> exa
alias exa='exa --git'
alias ls='exa'
alias ll='exa -l'
alias la='exa -la'
alias lt='exa -T'
alias lr='exa -R'
alias lat='exa -laT'
alias lar='exa -laR'

export CLICOLOR=1
#export TERM=xterm-256color

# Show root of tmux session in polybar
# mostly because TERM=.... tmux is ugly
if [ -n "$TMUX" ]; then
    xdotool set_window --name "tmux: $(dirs)" "$(xdotool getactivewindow)"
fi

export SUDO_EDITOR=/usr/bin/nvim
export EDITOR=/usr/bin/nvim

export _Z_DATA=/home/leon/z/.z.

PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'
source ~/dotfiles/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

# Print coloured motd
echo -e "\033[1m$(cat ~/dotfiles/motd/$(ls ~/dotfiles/motd/ | shuf -n 1))\033[0m"

LD_LIBRARY_PATH=/usr/local/lib
export LD_LIBRARY_PATH

export LC_ALL=en_US.utf-8 export LANG=en_US.utf-8

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source ~/.fzf.zsh

export PATH="$JAVA_HOME/bin:$PATH"

#(cat ~/.cache/wal/sequences &)

# Import colorscheme from 'wal'
(cat /home/leon/.cache/wal/sequences)

# source wal colors
. ~/.cache/wal/colors.sh

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

# Use neovim as MANPAGER
export MANPAGER='nvim +Man!'

export ANDROID_SDK_ROOT='/home/leon/Android/Sdk/'
#export ANDROID_SDK_HOME='/home/leon/.android/'
export ANDROID_SDK_HOME='/home/leon/Android/Sdk/'
#export ANDROID_HOME='/home/leon/Android/Sdk/'
export ANDROID_AVD_HOME='/home/leon/.android/avd/'
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# add cargo bins to path
export PATH="$HOME/.cargo/bin:$PATH"

# grc alias support
[[ -s "/etc/grc.zsh" ]] && source /etc/grc.zsh

function reqcat {
    cat $1 | grcat /usr/share/grc/conf.x-www-form-urlencoded
}
export reqcat

function getip {
     host $1 | awk '{print $4}' | sed -n '1p';
}
export getip

autoload -U promptinit; promptinit
prompt pure
#export PURE_PROMPT_SYMBOL="❯"
export PURE_PROMPT_SYMBOL="%F{white}%F{blue}%f"
