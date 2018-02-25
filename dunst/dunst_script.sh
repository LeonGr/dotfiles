. "${HOME}/.cache/wal/colors.sh"

sed -i -e 197,224d /home/leon/dotfiles/dunst/dunstrc

echo "
[urgency_low]
    # IMPORTANT: colors have to be defined in quotation marks. # Otherwise the \"#\" and following would be interpreted as a comment.
    background = \""${color0}"\"
    foreground = \"""${color3}""\"
    timeout = 10
    # Icon for notifications with low urgency, uncomment to enable #icon = /path/to/icon

[urgency_normal]
    background = \""${color0}"\"
    foreground = \"""${color3}""\"
    timeout = 10
    # Icon for notifications with normal urgency, uncomment to enable #icon = /path/to/icon

[urgency_critical]
    background = \""${color0}"\"
    foreground = \"""${color3}""\"
    timeout = 10 # Icon for notifications with critical urgency, uncomment to enable
    #icon = /path/to/icon

[frame]
    width = 5
    color = \"""${color3}""\"
" >> /home/leon/dotfiles/dunst/dunstrc
