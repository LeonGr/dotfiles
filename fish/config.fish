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
alias aurfind="echo 'use paruz'"
alias tmux='echo $KITTY_LISTEN_ON > /tmp/kitty-pid; /usr/bin/tmux'
alias mv='mv -i' # (--interactive) confirm overwrites
alias cp='cp -i' # (--interactive) confirm overwrites
alias scrot="scrot --exec 'xclip -selection clipboard -target image/png -in \$f'"
alias dmesg='dmesg -H'
alias b='bat'
alias bp='bat --paging=always'
alias c='cat'
alias clip='xclip -selection clipboard'
alias n='nvim'
alias icat='kitty +kitten icat'
alias dia_ping='ssh -t leon@dia grc ping' # -t forces pseudo-terminal allocation (for allowing colored output)
alias dia_curl='ssh -t leon@dia curl -v -L' # -t forces pseudo-terminal allocation (for allowing colored output)
alias fda='fd --hidden --no-ignore' # mnemonic: fd-all
alias neofetch="echo 'use fastfetch'"
alias nc="rlwrap nc"

# paru
alias p-qo='paru -Qo'
alias p-qi='paru -Qi'
alias p-si='paru -Si'
alias p-ss='paru -Ss'
alias p-rns='paru -Rns'

# ssh targets
alias jupi='ssh -Y leon@jupiter'
alias calli='ssh -Y leon@callisto'
alias gany='ssh leon@ganymedes'
alias euro='ssh -Y leon@europa'
alias leda='ssh leon@leda'
alias elara='ssh root@elara'
alias pandia='ssh leon@pandia'
alias dia='ssh leon@dia'
alias lysi='ssh leon@lysithea'
alias harp='ssh leon@harpalyke'

# ls -> eza
alias eza='eza --git'
alias ls='eza'
alias ll='eza --long'
alias la='eza --long -all -all' # double --all shows '.' and '..'
alias lt='eza --tree'
alias llt='eza --long --tree'
alias lr='eza --recurse'
alias lat='eza --long --all --tree'
alias lar='eza --long --all --all --recurse'

# deleting (https://github.com/andreafrancia/trash-cli)
alias rm='echo "Use trash (t)"; false'
alias t='trash'

### abbreviations ###
abbr --add ta 'tmux attach-session -t'
abbr --add ii 'ipinfo'

## systemctl
abbr --add sc 'systemctl'
abbr --add ssc 'sudo systemctl'

# status
abbr --add scs 'systemctl status'
abbr --add sscs 'sudo systemctl status'
abbr --add scus 'systemctl --user status'

# restart
abbr --add scur 'systemctl --user restart'
abbr --add sscr 'sudo systemctl restart'

# daemon-reload
abbr --add sscd 'sudo systemctl daemon-reload'
abbr --add scud 'systemctl --user daemon-reload'

# cat
abbr --add scc 'systemctl cat'
abbr --add scuc 'systemctl --user cat'

# stop (k = kill)
abbr --add ssck 'sudo systemctl stop'
abbr --add scuk 'systemctl --user stop'

# start (i = init)
abbr --add ssci 'sudo systemctl start'
abbr --add scui 'systemctl --user start'

## journalctl
abbr --add jc 'journalctl'
abbr --add jcfu 'journalctl -f -u'
abbr --add jcstfu 'journalctl --since today -f -u'
abbr --add jck 'journalctl -k'
abbr --add jcfk 'journalctl -f -k'
abbr --add jcstk 'journalctl --since today -k'
abbr --add jcstfk 'journalctl --since today -k'


# 'hostname' requires inetutils (on Arch)
if test (hostname) = "callisto"
    alias weechat='TERM=tmux-256color /usr/bin/weechat'
else
    alias weechat='ssh -t leon@callisto "tmux -L weechat attach-session"'
end

# git aliases
source ~/.config/fish/git.fish

# cargo aliases
source ~/.config/fish/cargo.fish

# set neovim as editor
set -x SUDO_EDITOR /usr/bin/nvim
set -x EDITOR /usr/bin/nvim
set -x COLORTERM "truecolor"


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
try_add_path "$HOME/.cargo/bin"

# add personal bins to path
try_add_path "$HOME/bin"

set -x GOPATH "$HOME/.go"

# needed for pinentry-tty gpg-agent
set -x GPG_TTY (tty)

# Make fzf start in a tmux popup
set -x FZF_DEFAULT_OPTS "--tmux 90%"

set -x KUBECONFIG ~/GitClones/LeonGr/Harpalyke-Infrastructure/cluster-admin.kubeconfig

# generic colouriser alias support (https://github.com/garabik/grc)
source /etc/grc.fish

function start_keychain
    keychain --eval $SSH_KEYS_TO_AUTOLOAD | source
end

if status is-interactive
    # Add set -U SSH_KEYS_TO_AUTOLOAD <key-1> <key-2> ... <key-n>
    # to ~/.config/fish/conf.d/fish-ssh-agent.fish
    if which keychain &> /dev/null
        start_keychain &> /tmp/keychain.log
    end

    # set window name of tmux terminal to 'tmux: $dir' where $dir is the starting directory
    if [ -n "$TMUX" ] && command -v xdotool &> /dev/null
        set -l dir (dirs)
        set -l tmux_session_name (tmux display-message -p '#S')
        set -l host_name (hostname)
        xdotool set_window --name "[$host_name] tmux: $dir [$tmux_session_name]" (xdotool getactivewindow)
        set -x KITTY_LISTEN_ON (bat /tmp/kitty-pid)
    end

    if [ -n "$KITTY_LISTEN_ON" ]
        # always highlight URLs kitty
        set URL_PREFIXES "http|https|file|ftp|gemini|irc|gopher|mailto|news|git"
        set URL_REGEX "($URL_PREFIXES):\/\/([\w\-_]+(?:(?:\.[\w\-_]+)+))([\w\-\.,@?^=%&:/~\+#]*[\w\-\@?^=%&/~\+#])?"
        kitty @ --to $KITTY_LISTEN_ON create-marker regex 1 $URL_REGEX
    end

end

# Insert mode cursor should be line
set -g fish_cursor_insert line

set -U __done_min_cmd_duration 5000

#  only execute these in tty
if tty > /dev/null
    # source wal colors
    if test -e ~/.cache/wal/sequences
        cat ~/.cache/wal/sequences &
    end

    # Set color of the matched part of a history search (up/down arrow).
    # This seems to have been changed to equal 'black' (without background),
    # so it was indistinguishable from the background itself.
    set -g fish_color_search_match 'white' --background 'brblack'

    if status --is-interactive
        funcsave --quiet take

        # register atuin
        if command -q atuin
            atuin init fish --disable-up-arrow | source
        end

        if type -q backup_check
            backup_check
        end

        # if fancy_motd command exists
        if command -q fancy_motd
            # if $TMUX is unset, i.e. not inside tmux
            if test -z "$TMUX"
                fancy_motd
            end
        else if command -q pokemon-colorscripts
            # print random pokemon from gen 1-5 (AUR: pokemon-colorscripts-git)
            pokemon-colorscripts --random 1-5
        else if test -d ~/dotfiles/motd/ &> /dev/null
            # print coloured motd
            cat ~/dotfiles/motd/(ls ~/dotfiles/motd/ | shuf -n 1); echo ""
        end
    end
end
