
if (( ! EUID )); then
    HISTFILE="$ZSH_CACHE/history_root"
else
    HISTFILE="$ZSH_CACHE/history"
fi

export SAVEHIST=10000
export HISTSIZE=10000000
export HISTORY_IGNORE="(ls|cd|pwd|exit|cd|mv|rm|slock|now|rdsk)"

setopt share_history
setopt append_history
setopt extended_history
setopt hist_no_store
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_expand
setopt hist_reduce_blanks

history-all() { history -E 1}

