#!/bin/sh

SCRIPT=$(realpath -s "$0")
SSH_CONFIG_DIR=$(dirname "$SCRIPT")

ln -fsnv "$SSH_CONFIG_DIR/machines/$(hostname)" "$HOME/.ssh"

chmod -v -R og-rwx "$SSH_CONFIG_DIR"
chmod -v -R og-rwx "$HOME/.ssh/"
