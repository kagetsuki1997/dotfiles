if [[ $ZSH_PROMPT_STYLE == "powerline-go" ]]; then
    source $ZSH_CONFIG/prompt.d/powerline-go.zsh
else
    source $ZSH_CONFIG/prompt.d/default.zsh
fi

switch-prompt-style() {
    ZSH_PROMPT_STYLE=$1 exec zsh
}
