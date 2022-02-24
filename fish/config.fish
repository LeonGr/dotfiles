#set -x HISTFILE ~/.zsh_history
set -x HISTSIZE 999999999
set -x SAVEHIST $HISTSIZE

# aliases
alias phpserver='php -S localhost:8000'
alias pythonserver='python -m http.server'
alias py='python'
alias :wq='exit'
alias :q='exit'
alias ack='ack-grep'
alias msfconsole="/opt/metasploit/msfconsole -x \"db_connect $USER@msf\""
alias p='xclip -o'
alias music='echo "Song: " && playerctl metadata "xesam:title" && echo "\nAlbum: " && playerctl metadata "xesam:album" && echo "\nArtist: " && playerctl metadata "xesam:albumArtist"'
alias exuent='exit'
alias spotify='spotify --force-device-scale-factor=1.5'
alias rofi-emoji='rofi -show emoji -modi emoji'
#alias status='sudo systemctl status'
alias stop='sudo systemctl stop'
alias start='sudo systemctl start'
alias restart='sudo systemctl restart'
alias sus='systemctl suspend'
alias aurfind="echo 'use paruz'"
# alias aurfind="paru -Slq | fzf -m --preview 'cat (paru -Si {1} | psub) (paru -Fl {1} | awk \"{print \$2}\" | psub)' | xargs -ro  paru -S"
#alias aurfind="paru -Slq | fzf -m --preview 'cat <(paru -Si {1}) <(paru -Fl {1} | awk \"{print \$2}\")' | xargs -ro  paru -S"
# alias tmux='TERM=xterm-256color /usr/bin/tmux' # make cursor work
alias tmux='echo $KITTY_LISTEN_ON > /tmp/kitty-pid; /usr/bin/tmux'
alias mv='mv -i' # (--interactive) confirm overwrites
alias cp='cp -i' # (--interactive) confirm overwrites
alias scrot="scrot --exec 'xclip -selection clipboard -target image/png -in \$f'"
alias weechat='TERM=tmux-256color /usr/bin/weechat'

# ls -> exa
alias exa='exa --git'
alias ls='exa'
alias ll='exa -l'
alias la='exa -la'
alias lt='exa -T'
alias lr='exa -R'
alias lat='exa -laT'
alias lar='exa -laR'

# set window name of tmux terminal to 'tmux: $dir' where $dir is the starting directory
if [ -n "$TMUX" ] && command -v xdotool &> /dev/null
    set dir (dirs); xdotool set_window --name " tmux: $dir" (xdotool getactivewindow)
    set -x KITTY_LISTEN_ON (bat /tmp/kitty-pid)
end

if [ -n "$KITTY_LISTEN_ON" ]
    # always highlight URLs kitty
    set URL_PREFIXES "http|https|file|ftp|gemini|irc|gopher|mailto|news|git"
    set URL_REGEX "($URL_PREFIXES):\/\/([\w\-_]+(?:(?:\.[\w\-_]+)+))([\w\-\.,@?^=%&:/~\+#]*[\w\-\@?^=%&/~\+#])?"
    kitty @ --to $KITTY_LISTEN_ON create-marker regex 1 $URL_REGEX
end

# git aliases
source ~/.config/fish/git.fish

# set neovim as editor
set -x SUDO_EDITOR /usr/bin/nvim
set -x EDITOR /usr/bin/nvim

# set location of z files
set -x Z_DATA /home/leon/z/.z.

set -x COLORTERM "truecolor"

# print coloured motd
#cat ~/dotfiles/motd/(ls ~/dotfiles/motd/ | shuf -n 1); echo ""

# print randomly coloured fish logo
function random_fish
    set colors '["bf8b56", "bfbf56", "8bbf56", "56bf8b", "568bbf", "8b56bf", "bf568b", "bf5656", "ffffff"]'
    set color_sample (python -c 'import random; print(" ".join(random.sample('$colors', 3)))')
    set args (string split ' ' $color_sample)
    fish_logo $args
    echo ""
end

#  only execute these in tty
if tty > /dev/null
    if status --is-interactive
        random_fish
    end

    # source wal colors
    cat ~/.cache/wal/sequences &
end


# give man colors
set -x MANROFFOPT '-c'
set -x LESS_TERMCAP_mb (tput bold; tput setaf 1)
set -x LESS_TERMCAP_md (tput bold; tput setaf 6)
set -x LESS_TERMCAP_me (tput sgr0)
set -x LESS_TERMCAP_so (tput bold; tput setaf 3; tput setab 4)
set -x LESS_TERMCAP_se (tput rmso; tput sgr0)
set -x LESS_TERMCAP_us (tput smul; tput bold; tput setaf 7)
set -x LESS_TERMCAP_ue (tput rmul; tput sgr0)
set -x LESS_TERMCAP_mr (tput rev)
set -x LESS_TERMCAP_mh (tput dim)

# use neovim as MANPAGER
set -x MANPAGER 'nvim +Man!'

# add cargo bins to path
set PATH $PATH "$HOME/.cargo/bin:$PATH"

# needed for pinentry-tty gpg-agent
set -x GPG_TTY (tty)

# generic colouriser alias support (https://github.com/garabik/grc)
source /etc/grc.fish

# fuck alias
function fuck -d "Correct your previous console command"
    set -l fucked_up_command $history[1]
    env TF_SHELL=fish TF_ALIAS=fuck PYTHONIOENCODING=utf-8 thefuck $fucked_up_command THEFUCK_ARGUMENT_PLACEHOLDER $argv | read -l unfucked_command

    if [ "$unfucked_command" != "" ]
        eval $unfucked_command
        builtin history delete --exact --case-sensitive -- $fucked_up_command
        builtin history merge
    end
end

# theme-updater with automatic history merge
function udt
    theme-updater &
    builtin history merge
end

# fish Vi-style keybindings with Emacs keybindings in insert mode
function fish_user_key_bindings
    fish_default_key_bindings -M insert
    fish_vi_key_bindings --no-erase insert
    fzf_key_bindings
end

# Insert mode cursor should be line
set -g fish_cursor_insert line

set -U __done_min_cmd_duration 5000
