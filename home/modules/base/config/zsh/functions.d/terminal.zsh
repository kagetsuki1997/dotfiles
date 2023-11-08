if type alacritty >/dev/null 2>&1; then
    function start-new-alacritty() {
        local WD=$PWD
        if [ $# -ge 1 ]; then
            WD=$1
        fi

        $SHELL -c "alacritty --working-directory $WD > /dev/null 2>&1 &"
    }

    alias na="start-new-alacritty"
    alias nt="start-new-alacritty"

    bindkey -s '^_' "^Q start-new-alacritty ^J"
fi
