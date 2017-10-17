# Default Theme

if patched_font_in_use; then
    TMUX_POWERLINE_SEPARATOR_LEFT_BOLD=""
    TMUX_POWERLINE_SEPARATOR_LEFT_THIN=""
    TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD=""
    TMUX_POWERLINE_SEPARATOR_RIGHT_THIN=""
else
    TMUX_POWERLINE_SEPARATOR_LEFT_BOLD="◀"
    TMUX_POWERLINE_SEPARATOR_LEFT_THIN="❮"
    TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD="▶"
    TMUX_POWERLINE_SEPARATOR_RIGHT_THIN="❯"
fi

TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR:-'235'}
TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR:-'255'}

TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD}
TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}


# Format: segment_name background_color foreground_color [non_default_separator]

if [ -z $TMUX_POWERLINE_LEFT_STATUS_SEGMENTS ]; then
    TMUX_POWERLINE_LEFT_STATUS_SEGMENTS=(
        #"tmux_session_info 148 234" \
        #"hostname 198 0" \
        # maybe: 4 6 12 48 18 19 20 21 24 26!
        #"ifstat 30 255" \
        #"ifstat_sys 30 255" \
        "lan_ip 40 0 ${TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD}" \
        #"vcs_branch 29 88" \
        #"vcs_compare 60 255" \
        #"vcs_staged 64 255" \
        #"vcs_modified 9 255" \
        #"vcs_others 245 0" \
    )
fi

if [ -z $TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS ]; then
    TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS=(
        #"earthquake 3 0" \
        "pwd 4 255" \
        #"now_playing 6 255"\
        #"cpu 240 136" \
        #"load 237 167" \
        #"tmux_mem_cpu_load 234 136" \
        #"rainbarf 0 0" \
        #"xkb_layout 125 148" \
        "date_day 160 0" \
        "date 160 0 ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN}" \
        "time 160 0 ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN}" \
        #"utc_time 235 136 ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN}" \
    )
fi
