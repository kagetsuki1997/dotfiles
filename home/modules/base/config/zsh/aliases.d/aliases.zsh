alias zedit=' $EDITOR $ZSH_CONFIG/zshrc; source $ZSH_CONFIG/zshrc'
alias aedit=' $EDITOR $ZSH_CONFIG/aliases.d/aliases.zsh; source $ZSH_CONFIG/aliases.d/aliases.zsh'
alias fedit=' $EDITOR $ZSH_CONFIG/functions.zsh; source $ZSH_CONFIG/functions.zsh'
alias pedit=' $EDITOR $ZSH_CONFIG/private.zsh; source $ZSH_CONFIG/private.zsh'
alias viedit=' $EDITOR $HOME/.config/nvim/init.vim'

alias grep='grep --color=auto'

alias now='date "+%Y-%m-%d %H:%M:%S %z"'

alias a.out='./a.out'

if type xenon >/dev/null 2>&1; then
    alias myip='xenon myip'
    alias rnm='xenon rename-file'
fi

##### standard aliases (start with a space to be ignored in history)
# default ls is untouched, except coloring
if type exa >/dev/null 2>&1; then
    alias myls='exa -s type'
    alias ls='exa -s type'
    alias la='exa -la -s type'
else
    alias myls=' ls -C -F -h --color=always'
    alias ls=' ls --color=auto'
    alias la=' myls -lA --time-style=long-iso'
fi

alias l=' myls -l --time-style=long-iso'
alias ll=' myls -l --time-style=long-iso'
alias lr='ls -R'
alias v=' clear; ll -gh' # standard directory view
alias vs=' v **/*(.)'    # show all files in all subdirs plain in a list

alias cloc="tokei"

alias p=' ps aux | grep'
alias g='git'
alias d=' dirs -v'
alias ka='killall'

alias cd=' cd'
alias ..=' cd ..; ls'
alias ...=' cd ..; cd ..; ls'
alias ....=' cd ..; cd ..; cd ..; ls'
alias cd..='..'
alias cd...='...'
alias cd....='....'

#### Change Directory
alias home='cd $HOME'
alias dwnl='cd $HOME/Downloads/'
alias dwnl2='cd $HOME/Downloads2/'
alias dwnl3='cd $HOME/Downloads3/'
alias scrpt='cd $HOME/scripts/'
alias msc='cd $HOME/Music/'
alias prj='cd $HOME/projects/'
alias dotfiles='cd $HOME/dotfiles/'

alias rdsk='cd $HOME/ramdisk/'
alias rdsk-cache='cd /tmp/$USER-cache/'
alias rdsk-code='cd $HOME/ramdisk/code'
alias rdsk-dwnl='cd $HOME/ramdisk/downloads'
alias rdsk-mnt='cd $HOME/ramdisk/mnt'
alias rdsk-tmp='cd $HOME/ramdisk/tmp'

#### Show progress when copying file or moving file
alias rscp='rsync -P'
alias rscpa='rsync -aP'
alias rsmv='rsync -P --remove-source-files'
alias rsmva='rsync -aP --remove-source-files'

alias cpr='rsync -a --human-readable --progress '

alias k9='kill -9'

# iproute
alias ip='ip -c '

# Containers and related tools
alias kc="kubectl "

# Battery cycle count
alias battery-cycle-count='cat /sys/class/power_supply/BAT0/cycle_count'
alias battery-uevent='cat /sys/class/power_supply/BAT0/uevent'

alias open=' xdg-open $@'
alias ]=' xdg-open $@'

alias html='$BROWSER $@'
alias mkv='mpv $@'

alias prettier-json='prettier --parser=json'
