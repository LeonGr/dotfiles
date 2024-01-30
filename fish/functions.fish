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
        set backup_service "$argv[1]"

        # Print name of service
        echo $backup_service

        # Print time of last backup
        set backup_datetime (systemctl show $backup_service --property=ExecMainStartTimestamp | sd 'ExecMainStartTimestamp=' '')
        set backup_datetime_epoch (date --date=$backup_datetime '+%s')
        set current_datetime_epoch (date '+%s')
        set days_diff (math --scale 0 \($current_datetime_epoch - $backup_datetime_epoch\) / 86400)

        echo -e "last backup: $backup_datetime"
        if test $days_diff -gt 0
            echo -e "[30;41m $days_diff days since last backup \033[0m"
        end

        # Print status of last backup
        set backup_status (systemctl show -p MainPID -p ActiveState --value $backup_service)
        set backup_status_type $backup_status[2]

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

    else
        echo -e "No service supplied"
    end
end

# show when last backup was
function backup_check
    backup_check_single backup.service
    backup_check_single backup_restic.service
    backup_check_single backup_restic_callisto.service
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
            commandline --replace "git switch $selected"
        end
    else
        echo "not a git repository" 1>&2
        return -1
    end
end
