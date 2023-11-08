export NIX_PAGER=less

alias nix-zsh="nix-shell --run 'exec zsh' "

nix-which() {
    readlink -f $(which $1)
}

nix-which-dir() {
    dirname $(nix-which $1)
}

nix-pkgdir() {
    dirname $(dirname $(nix-which $1))
}

cd-nix-pkgdir() {
    cd $(nix-pkgdir $1)
}
