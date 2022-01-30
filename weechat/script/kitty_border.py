import weechat
import os

#  weechat.register(SCRIPT_NAME, SCRIPT_AUTHOR, SCRIPT_VERSION, SCRIPT_LICENSE, SCRIPT_DESC, '', '')
weechat.register("kitty_border", "leon", "1.0", "GPL3", "Remove kitty terminal margin", "", "")

weechat.prnt("", "Start kitty margin script")

def quit_signal_cb(data, signal, signal_data):
    os.system("kitty @ --to $KITTY_LISTEN_ON set-spacing margin=8")
    return weechat.WEECHAT_RC_OK

weechat.hook_signal('quit', 'quit_signal_cb', '')

os.system("kitty @ --to $KITTY_LISTEN_ON set-spacing margin-bottom=8 margin-left=0 margin-right=0")

weechat.prnt("", "Finished kitty margin script")
