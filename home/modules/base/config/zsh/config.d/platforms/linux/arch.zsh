COMMAND_NOT_FOUND_PATH="/usr/share/doc/pkgfile/command-not-found.zsh"

if [[ -f $COMMAND_NOT_FOUND_PATH ]]; then
    source $COMMAND_NOT_FOUND_PATH
fi

alias pkg-update="sudo pacman -Sy"
alias pkg-upgrade="yaourt -Syu --aur"
alias pkg-install="sudo pacman -S"
alias pkg-remove="sudo pacman -R"
alias pkg-purge="sudo pacman -Rns"
alias pkg-list="yaourt -Q"
alias pkg-info="yaourt -Qi"
alias pkg-count="pacman -Qq | wc -l"

pkg-which() {
    for x in $@; do
        result=$(which $x)
        if [[ $result[1] == "/" ]]; then
            pacman -Ql | grep "$result$"
        else
            echo "$result"
        fi
    done
}
