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
alias b='bat'
alias c='cat'
alias clip='xclip -selection clipboard'
alias ppa='podman ps -a'
alias n='nvim'
alias icat='kitty +kitten icat'
alias dia_ping='ssh -t leon@dia grc ping' # -t forces pseudo-terminal allocation (for allowing colored output)
alias dia_curl='ssh -t leon@dia curl -v -L' # -t forces pseudo-terminal allocation (for allowing colored output)

# paru
alias pqo='paru -Qo'
alias pqi='paru -Qi'
alias psi='paru -Si'
alias pss='paru -Ss'
alias prns='paru -Rns'

# ssh targets
alias jupi='ssh -Y leon@jupiter'
alias calli='ssh -Y leon@callisto'
alias gany='ssh pi@ganymedes'
alias euro='ssh -Y leon@europa'
alias leda='ssh leon@leda'
alias elara='ssh root@elara'
alias pandia='ssh leon@pandia'
alias dia='ssh leon@dia'

# ls -> eza
alias eza='eza --git'
alias ls='eza'
alias ll='eza -l'
alias la='eza -laa'
alias lt='eza -T'
alias lr='eza -R'
alias lat='eza -laT'
alias lar='eza -laaR'

# deleting (https://github.com/andreafrancia/trash-cli)
alias rm='echo "Use trash (t)"; false'
alias t='trash'

set light_theme "gruvbox-light"
set dark_theme "TwoDark"
set colorscheme_file "/opt/theme_colorscheme"

# change bat colorscheme based on theme
function bat
    if test -e $colorscheme_file
        and test (cat $colorscheme_file) = "light"
        /usr/bin/bat --theme=$light_theme $argv
    else
        /usr/bin/bat --theme=$dark_theme $argv
    end
end

# 'hostname' requires inetutils (on Arch)
if test (hostname) = "callisto"
    alias weechat='TERM=tmux-256color /usr/bin/weechat'
else
    alias weechat='ssh -t leon@callisto "tmux attach-session -t weechat"'
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

# git aliases
source ~/.config/fish/git.fish

# cargo aliases
source ~/.config/fish/cargo.fish

# set neovim as editor
set -x SUDO_EDITOR /usr/bin/nvim
set -x EDITOR /usr/bin/nvim
set -x COLORTERM "truecolor"


#  only execute these in tty
if tty > /dev/null
    if status --is-interactive
        funcsave --quiet take

        # register atuin
        if command -v atuin &> /dev/null
            atuin init fish --disable-up-arrow | source
        end

        # if fancy_motd command exists
        if command -v fancy_motd &> /dev/null
            # if $TMUX is unset, i.e. not inside tmux
            if test -z "$TMUX"
                fancy_motd
            end
        else if command -v pokemon-colorscripts &> /dev/null
            # print random pokemon from gen 1-5 (AUR: pokemon-colorscripts-git)
            pokemon-colorscripts --random 1-5
        else if test -d ~/dotfiles/motd/ &> /dev/null
            # print coloured motd
            cat ~/dotfiles/motd/(ls ~/dotfiles/motd/ | shuf -n 1); echo ""
        end


        if type -q backup_check &> /dev/null
            backup_check
        end
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
fish_add_path --append "$HOME/.cargo/bin"

# add personal bins to path
fish_add_path --append "$HOME/bin"

set -x GOPATH "$HOME/.go"

# needed for pinentry-tty gpg-agent
set -x GPG_TTY (tty)

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
end

# Insert mode cursor should be line
set -g fish_cursor_insert line

set -U __done_min_cmd_duration 5000
