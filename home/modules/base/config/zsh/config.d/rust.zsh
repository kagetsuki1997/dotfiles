if type rustc >/dev/null 2>&1; then
    export RUSTC_WRAPPER=sccache
    path=(
        "$HOME/.cargo/bin"
        $path
    )
fi
