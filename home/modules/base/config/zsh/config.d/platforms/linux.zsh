# if we have a screen, we can try a colored screen
if [[ $TERM == "screen" ]]; then
    export TERM="screen-256color"
fi

# activate ls colors, (private if possible)
export ZSH_DIRCOLORS="$ZSH_CONFIG/dircolors/moonshine.dircolors"
if [[ -e $ZSH_DIRCOLORS ]]; then
    if [[ $TERM == *256* || $TERM == "xterm-kitty" || $TERM == "xterm-termite" ]]; then
        which dircolors >/dev/null && eval "$(dircolors -b $ZSH_DIRCOLORS 2>/dev/null)"
    else
        # standard colors for non-256-color terms
        which dircolors >/dev/null && eval "$(dircolors -b)"
    fi
else
    which dircolors >/dev/null && eval "$(dircolors -b)"
fi

DISTRO_CONFIG_DIR="$ZSH_CONFIG/config.d/platforms/linux"

if [[ $LINUX_DISTRO == "NixOS" ]]; then
    source "$DISTRO_CONFIG_DIR/nixos.zsh"
elif [[ $LINUX_DISTRO == "Arch" ]]; then
    source "$DISTRO_CONFIG_DIR/arch.zsh"
elif [[ $LINUX_DISTRO == "Debian" || $LINUX_DISTRO == "Ubuntu" ]]; then
    source "$DISTRO_CONFIG_DIR/debian.zsh"
fi

function kbdreset() {
    if type xset >/dev/null 2>&1; then
        xset r rate 200 20
    else
        echo "Error: xset not found"
    fi
}
