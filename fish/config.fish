#set -x HISTFILE ~/.zsh_history
set -x HISTSIZE 999999999
set -x SAVEHIST $HISTSIZE

### aliases ###
alias phpserver='php -S localhost:8000'
alias pythonserver='python -m http.server'
alias py='python'
alias :wq='exit'
alias :q='exit'
alias music='echo "Song: " && playerctl metadata "xesam:title" && echo "\nAlbum: " && playerctl metadata "xesam:album" && echo "\nArtist: " && playerctl metadata "xesam:albumArtist"'
alias exuent='exit'
alias spotify='spotify --force-device-scale-factor=1.5'
alias rofi-emoji='rofi -show emoji -modi emoji'
alias sus='systemctl suspend'
alias aurfind="echo 'use paruz'"
alias tmux='echo $KITTY_LISTEN_ON > /tmp/kitty-pid; /usr/bin/tmux'
alias mv='mv -i' # (--interactive) confirm overwrites
alias cp='cp -i' # (--interactive) confirm overwrites
alias scrot="scrot --exec 'xclip -selection clipboard -target image/png -in \$f'"
alias g.='git status .'
alias dmesg='dmesg -H'
alias gswi='git_switch_fzf'

# 'hostname' requires inetutils (on Arch)
if test (hostname) = "callisto"
    alias weechat='TERM=tmux-256color /usr/bin/weechat'
else
    alias weechat='ssh -t leon@callisto "tmux attach-session -t weechat"'
end

# ls -> exa
alias exa='exa --git'
alias ls='exa'
alias ll='exa -l'
alias la='exa -la'
alias lt='exa -T'
alias lr='exa -R'
alias lat='exa -laT'
alias lar='exa -laR'

# deleting (https://github.com/andreafrancia/trash-cli)
alias rm='echo "Use trash (t)"; false'
alias t='trash'

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
set -x COLORTERM "truecolor"


#  only execute these in tty
if tty > /dev/null
    if status --is-interactive
        funcsave --quiet take

        # if fancy_motd command exists
        if command -v fancy_motd &> /dev/null
            # if $TMUX is unset, i.e. not inside tmux
            if test -z "$TMUX"
                fancy_motd
            end
        else
            # print coloured motd
            cat ~/dotfiles/motd/(ls ~/dotfiles/motd/ | shuf -n 1); echo ""
        end


        backup_check
    end

    # source wal colors
    if test -e ~/.cache/wal/sequences
        cat ~/.cache/wal/sequences &
    end
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
fish_add_path -a "$HOME/.cargo/bin"

# add personal bins to path
fish_add_path -a "$HOME/bin"

set -x GOPATH "$HOME/.go"

# needed for pinentry-tty gpg-agent
set -x GPG_TTY (tty)

# generic colouriser alias support (https://github.com/garabik/grc)
source /etc/grc.fish

if status is-login
    and status is-interactive
    # Add set -U SSH_KEYS_TO_AUTOLOAD <key-1> <key-2> ... <key-n>
    # to ~/.config/fish/conf.d/fish-ssh-agent.fish
    if which keychain &> /dev/null
        keychain --eval $SSH_KEYS_TO_AUTOLOAD &>> /tmp/keychain.log | source
    end
end

# Insert mode cursor should be line
set -g fish_cursor_insert line

set -U __done_min_cmd_duration 5000
