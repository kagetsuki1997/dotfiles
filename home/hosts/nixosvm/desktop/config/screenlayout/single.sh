#!/bin/sh

echo "Setup screenlayout..."

xrandr \
    --output HDMI-0 --mode 2560x1440 --pos 0x0 --rotate normal \
    --output VGA-0 --off \
    --output DVI-D-0 --off
