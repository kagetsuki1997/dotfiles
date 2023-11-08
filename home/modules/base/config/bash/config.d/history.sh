#!/usr/bin/env bash

HISTFILE="$BASH_CACHE/history"

export SAVEHIST=10000
export HISTSIZE=10000000
export HISTIGNORE="ls:rm:mv"
export HISTCONTROL="ignorespace"
