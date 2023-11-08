#!/bin/sh

if ! type nvim >/dev/null 2>&1; then
    echo "Neovim not found!"
    return
fi

if ! type git >/dev/null 2>&1; then
    echo "Git not found!"
    return
fi

PACKER_REPO_URL="https://github.com/wbthomason/packer.nvim"
PACKER_PATH="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"

if [ ! -d "$PACKER_PATH" ]; then
    echo "Downloading $PACKER_REPO_URL"
    git clone --depth 1 "$PACKER_REPO_URL" "$PACKER_PATH"
fi

echo 'Remember to run ":PackerInstall", ":PackerCompile", ":PackerClean"'
