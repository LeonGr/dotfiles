#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar
#MONITOR=eDP-1 polybar mybar &
MONITOR=DisplayPort-0 polybar mybar &

echo "Bars launched..."
