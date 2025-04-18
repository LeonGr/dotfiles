# print randomly coloured fish logo
function random_fish
    set colors '["bf8b56", "bfbf56", "8bbf56", "56bf8b", "568bbf", "8b56bf", "bf568b", "bf5656", "ffffff"]'
    set color_sample (python -c 'import random; print(" ".join(random.sample('$colors', 3)))')
    set args (string split ' ' $color_sample)
    fish_logo $args
    echo ""
end

function backup_check_single
    if set -q argv[1]
        set -l backup_service "$argv[1]"
        set -l service_owner "$argv[2]"

        if test $service_owner = "user"
            echo "$backup_service [--user]"
            set -f systemctl_command "systemctl --user"
        else
            echo $backup_service
            set -f systemctl_command "systemctl"
        end

        # First check if service exists
        if not eval "$systemctl_command list-unit-files \"$argv[1]\"" &>/dev/null
            echo "No such service"
            echo ""
        else
            # Print time of last backup
            set -l backup_datetime_command "$systemctl_command show '$backup_service' --property=ExecMainStartTimestamp | sd 'ExecMainStartTimestamp=' ''"
            set -l backup_datetime (eval $backup_datetime_command)
            set -l backup_datetime_epoch (date --date=$backup_datetime '+%s')
            set -l current_datetime_epoch (date '+%s')
            set -l days_diff (math --scale 0 \($current_datetime_epoch - $backup_datetime_epoch\) / 86400)

            echo -e "last backup: $backup_datetime"
            if test $days_diff -gt 0
                echo -e "[30;41m $days_diff days since last backup \033[0m"
            end

            # Print status of last backup
            set -l backup_status_command "$systemctl_command show -p MainPID -p ActiveState --value $backup_service"
            set -l backup_status (eval $backup_status_command)
            set -l backup_status_type $backup_status[2]

            echo -n "status: "
            # for color codes see: https://en.wikipedia.org/wiki/ANSI_escape_code#3-bit_and_4-bit
            switch $backup_status_type
                case "failed"
                    echo -e -n "[30;41m" # red
                case "active"
                    echo -e -n "[30;42m" # green
                case "activating"
                    echo -e -n "[30;43m" # yellow
                # case "inactive"
                    # echo -e -n "[30;44m" # blue
            end
            echo -n "$backup_status_type"
            echo -e -n "\033[0m"
            echo ""
            echo ""
        end
    else
        echo -e "No service supplied"
    end
end

# show when last backup was
function backup_check
    backup_check_single backup.service
    backup_check_single backup_restic.service
    backup_check_single backup_restic_callisto.service
    backup_check_single backup_duplicity_kdrive.service
    backup_check_single backup_obsidian.service "user"
end

# command that creates a directory and then changes the current directory to it
# inspired by zsh, taken from https://unix.stackexchange.com/a/678533/
function take
    mkdir -p "$argv[1]"; and cd "$argv[1]"
end

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

    # Re-enable old beheviour of Ctrl-C: leave typed text and show ^C.
    bind -M insert ctrl-c cancel-commandline
end

# select a git branch to switch to using fzf
function git_switch_fzf
    # check if we're in a git repo, discard both stdout and stderr
    if git rev-parse --is-inside-work-tree &> /dev/null
        set -l selected (
            # list all local and remote branches
            git branch --all --no-color --format="%(refname:short)" \
            # remove 'origin/' prefix from remote branches
            | sed 's|origin/||g' \
            # sort and remove duplicates
            | sort --unique \
            # send list to fzf with multi-select disabled
            | fzf --no-multi
        )

        if [ "$selected" != "" ]
            commandline --replace "git switch $selected # gswi" # identify replaced command with a comment
        end
    else
        echo "not a git repository" 1>&2
        return -1
    end
end

# query ipinfo.io
function ipinfo
    curl -s "https://ipinfo.io/$argv[1]" | jq
end

# query maclookup.app
function macinfo
    set -l mac $argv[1]
    echo "MAC: $mac"
    # Get first 3 octets only
    set -l stripped (echo "$mac" | string split : | head -n 3 | string join "")
    echo "Stripped: $stripped"

    curl -s "https://api.maclookup.app/v2/macs/$stripped" | jq
end

# search for man pages using fzf
function mans
    set -l man_page (apropos '' | fzf | sd '^(.*?)\s\((\d.?)\).*' '$2 $1')
    echo $man_page

    if [ "$man_page" != "" ]
        set -l man_command "man $man_page"
        commandline --replace $man_command
    end
end

# sysz automatically executes the selected command and doesn't add it to history.
# this uses a modified sysz which instead echoes the command, so we can add it to history.
function sysz
    set -l sysz_output (~/dotfiles/scripts/sysz-no-eval)

    if [ "$sysz_output" != "" ]
        commandline --replace "$sysz_output # sysz_wrapper" # identify replaced command with a comment
    end
end

# Find the package owning a file and show package info.
# Saves doing paru -Qo and then paru -Qi and paru -Si.
function p-o
    set -l owner (paru -Qo --quiet $argv[1])
    if [ $status = 0 ]
        echo "'$argv[1]' is owned by '$owner'"

        echo "### paru -Qi $owner: ###"
        paru -Qi $owner

        echo "### paru -Si $owner: ###"
        paru -Si $owner
    end
end

# Shorthand for 'podman ps -a', without certain unnecessary information to prevent line wrapping
function ppa
    set -l red '\033[31m'
    set -l green '\033[32m'
    set -l yellow '\033[33m'
    set -l blue '\033[34m'
    set -l magenta '\033[35m'

    set -l container_name "$green{{printf SPACE-42 .Names}}"
    set -l created_time "$blue{{printf SPACE-20 .CreatedHuman}}"
    set -l container_status "$yellow{{printf SPACE-30 .Status}}"
    set -l container_ports "$magenta{{printf SPACE-40 .Ports}}"

    set -l format_string \
        # 1. Create template string with colours, using printf.
        (printf \
            "$container_name $created_time $container_status $container_ports" \
            # 2. Replace the 'SPACE-<size>' placeholders with printf whitespace padding.
            #    This is done after adding the colours, so the first printf doesn't interpret the padding.
            | sd 'SPACE-(\d+)' '"%-${1}s"') \

    # 3. Print generated template string, which will also ensure the padding works.
    podman ps -a --format $format_string \
            # 4. Make the 'Exited' container status red.
            | sd '(\(Exited*\))' "$red\$1"
end

# Ask for confirmation, default No. Allows custom prompt argument.
function read_confirm
    set -l message ""
    if set -q argv[1]
        set message $argv[1]
    else
        set message "Do you want to continue?"
    end
    while true
        read -l -P "$message [y/N] " confirm

        switch $confirm
            case Y y
                return 0
            case '' N n
                return 1
        end
    end
end

# Select and kill multiple processes
function terminator
    # Show all lines from 'ps aux', except the first (header).
    # Get the PID part of the line with awk.
    set -l PIDs (grc --colour=on ps aux | fzf -m --ansi --header-lines=1 | awk '{print $2}')

    # Test if the $PIDs variable is non-empty
    if test -n "$PIDs"
        # Print selected processes
        ps --format "pid,user,command" -p $PIDs

        # Ask for confirmation to continue
        if read_confirm "Do you want to kill these processes?"
            # Check if we're root, otherwise use sudo
            if test "$EUID" -ne 0
                sudo kill $PIDs
            else
                kill $PIDs
            end
        end
    else
        echo "No processes selected"
    end
end

function try_add_path
    set -l path "$argv[1]"

    if test -d $path
        fish_add_path --append $path
    end
end
