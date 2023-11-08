powerline_precmd() {
    eval "$(
        powerline-go \
            -eval \
            -alternate-ssh-icon \
            -hostname-only-if-ssh \
            -theme default \
            -colorize-hostname \
            -cwd-mode plain \
            -shorten-eks-names \
            -shorten-gke-names \
            -error $? \
            -jobs $(jobs -p | wc -l) \
            -shell zsh \
            -modules venv,user,host,ssh,cwd,perms,git,hg,jobs,exit,root \
            -modules-right nix-shell,kube,docker-context,aws
    )"
}

install_powerline_precmd() {
    for s in "${precmd_functions[@]}"; do
        if [ "$s" = "powerline_precmd" ]; then
            return
        fi
    done
    precmd_functions+=(powerline_precmd)
}

if [[ $TERM != "linux" ]] && type powerline-go >/dev/null 2>&1; then
    install_powerline_precmd
else
    source $ZSH_CONFIG/prompt.d/default.zsh
fi
