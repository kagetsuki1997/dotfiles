#!/bin/sh

# Terminate already running bar instances
pkill polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# The primary output will be the first element
MONITORS=$(xrandr --listmonitors | sed '1d' | awk '{print $4}')
#MONITORS=$(xrandr --listmonitors | sed '2!d' | awk '{print $4}')

for m in $MONITORS; do
    echo "Monitor: $m"

    # Launch bar1 and bar2
    MONITOR=$m polybar --reload main-top &
    MONITOR=$m polybar --reload main-bottom &

    # Give some time for catching tray icon
    sleep 0.75
done

echo "Polybars launched..."
