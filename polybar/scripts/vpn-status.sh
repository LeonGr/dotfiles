#!/bin/sh

curl -s https://am.i.mullvad.net/connected | sd '^.*\(server (.*)\).*$' '$1' | rg -o '[^ ]+$'
