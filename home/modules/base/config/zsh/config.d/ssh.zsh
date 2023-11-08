if [[ -S "/run/user/${UID}/ssh-agent" ]]; then
    export SSH_AUTH_SOCK="/run/user/${UID}/ssh-agent"
fi
