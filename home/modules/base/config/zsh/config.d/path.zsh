typeset -U path cdpath fpath manpath

path=(
    $HOME/bin
    $XDG_BIN_HOME
    $path
)

fpath=(
    $ZSH_CONFIG/completion/ssh-tunnel
    $fpath
)
