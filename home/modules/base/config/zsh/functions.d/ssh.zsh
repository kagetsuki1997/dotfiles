alias scpr='rsync -P --rsh=ssh '

alias ssh-no-execute='ssh -NT '
alias ssh-proxy='ssh -NTD '
alias ssh-local-tunnel='ssh -fND 127.0.0.1:3128 localhost'

alias ssh-check='ssh -O check '
alias ssh-exit='ssh -O exit '
alias ssh-stop='ssh -O stop '

ssh-tunnel() {
    ssh -fNT $@
}

ssh-reconect-tunnel() {
    ssh -O exit $@
    ssh -fNT $@
}

ssh-tmux() {
    ssh -t $@ "tmux -u attach || tmux -u new"
}

ssh-cat() {
    ssh $1 "cat > $2"
}

ssh-add-all-keys() {
    rg --follow PRIVATE -l $HOME/.ssh-keyfiles | xargs ssh-add &>/dev/null || return 0
}

# PTT
alias ssh-ptt='ssh bbsu@ptt.cc'
