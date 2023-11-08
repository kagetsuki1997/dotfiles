#!/usr/bin/env sh

nohup alacritty --working-directory "$1" >/dev/null 2>&1 &
