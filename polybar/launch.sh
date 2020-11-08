#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
#while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar
echo "---" | tee -a /tmp/polybar.log
primaryMonitor=$(xrandr | grep -E " connected primary" | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/")
MONITOR=$primaryMonitor polybar mybar >>/tmp/polybar.log 2>&1 &

echo "Bars launched..."
