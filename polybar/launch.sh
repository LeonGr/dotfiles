#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
#while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar
#MONITOR=eDP-1 polybar mybar &
#MONITOR=DisplayPort-0 polybar mybar &
echo "---" | tee -a /tmp/polybar.log
#MONITOR=HDMI2 polybar mybar >>/tmp/polybar.log 2>&1 &
MONITOR=DP-1 polybar mybar #>>/tmp/polybar.log 2>&1 &

echo "Bars launched..."
