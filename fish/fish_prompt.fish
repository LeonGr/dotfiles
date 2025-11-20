function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
    set -l normal (set_color normal)

    # set syntax highlight colors (https://fishshell.com/docs/current/index.html#syntax-highlighting-variables)
    set fish_color_command green
    set fish_color_error red --bold
    set fish_color_comment 777
    set fish_color_param white
    set fish_color_redirection blue
    #set fish_color_search_match black

    ## git info (https://fishshell.com/docs/current/cmds/fish_git_prompt.html)
    # set color to grey
    set -g __fish_git_prompt_color 777

    # enable specific information
    set -g __fish_git_prompt_showdirtystate true
    set -g __fish_git_prompt_showuntrackedfiles true
    set -g __fish_git_prompt_showstashstate true
    set -g __fish_git_prompt_showupstream auto

    # set status colors
    # default
    #set -g __fish_git_prompt_showcolorhints true
    # custom
    set -g __fish_git_prompt_color_branch green
    set -g __fish_git_prompt_color_dirtystate green
    set -g __fish_git_prompt_color_stagedstate red
    set -g __fish_git_prompt_color_invalidstate cyan
    set -g __fish_git_prompt_color_upstream blue
    set -g __fish_git_prompt_color_merging magenta
    set -g __fish_git_prompt_color_untrackedfiles yellow
    set -g __fish_git_prompt_color_stashstate white

    # Use fancy icons
    set -g __fish_git_prompt_use_informative_chars true

    # Change some icons
    set -g __fish_git_prompt_char_upstream_equal ''         # default '='
    set -g __fish_git_prompt_char_upstream_diverged '↑↓'    # default '<>'

    # make prompt_pwd show the full length
    set -g fish_prompt_pwd_dir_length 0

    # Color the prompt differently when we're root
    set -l color_cwd $fish_color_cwd
    set -l suffix 'λ'
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        end
        set suffix '#'
    end

    # If we're running via SSH, change the host color.
    set -l color_host $fish_color_host
    if set -q SSH_TTY
        set color_host $fish_color_host_remote
    end

    # Write pipestatus
    # If the status was carried over (e.g. after `set`), don't bold it.
    set -l bold_flag --bold
    set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
    if test $__fish_prompt_status_generation = $status_generation
        set bold_flag
    end
    set __fish_prompt_status_generation $status_generation
    set -l prompt_status (__fish_print_pipestatus "[" "]" "|" (set_color $fish_color_status) (set_color $bold_flag $fish_color_status) $last_pipestatus)

    echo -n -s (set_color $fish_color_user) \n"$USER" $normal @ (set_color $color_host) (prompt_hostname) $normal ' ' (set_color $color_cwd) (prompt_pwd) $normal (fish_vcs_prompt) $normal " "$prompt_status \n$suffix " "
end
