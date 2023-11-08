if type yarn >>/dev/null 2>&1; then
    path=(
        "$(yarn global bin)"
        $path
    )
fi
