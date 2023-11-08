# http://www.commandlinefu.com/commands/view/7294/backup-a-file-with-a-date-time-stamp
function buf() {
    local oldname=$1
    if [ "$oldname" != "" ]; then
        local datepart=$(date +%Y-%m-%d)
        local firstpart=$(echo $oldname | cut -d "." -f 1)
        local newname=$(echo $oldname | sed s/$firstpart/$firstpart.$datepart/)
        cp -R $oldname $newname
    fi
}

function do-compress() {
    local format=$1
    local name=$2
    if [[ $name != "" ]]; then
        case $format in
            "bz2")
                tar cvjf "$name.tar.bz2" "$name"
                ;;
            "gz")
                tar cvzf "$name.tar.gz" "$name"
                ;;
            "zip")
                zip -r "$name.zip" "$name"
                ;;
            "7z")
                7zz a "$name.7z" "$name"
                ;;
            "rar")
                rar a "$name.rar" "$name"
                ;;
            *)
                echo "Unknown format"
                ;;
        esac
    else
        echo "Invalid file name" && return 1
    fi
}

function encrypt-compress() {
    local format=$1
    local name=$2
    if [[ $name != "" ]]; then
        case $format in
            "zip")
                zip -e -r $name.zip $name
                ;;
            "7z")
                7zz a -p $name.7z $name
                ;;
            "rar")
                rar a -p $$name.rar $name
                ;;
            *)
                echo "Unknown format"
                ;;
        esac
    else
        echo "Invalid file name" && return 1
    fi
}

function dobz2() {
    do-compress "bz2" $1
}

function dogz() {
    do-compress "gz" $1
}

function dozip() {
    do-compress "zip" $1
}

function do7z() {
    do-compress "7z" $1
}

function do7zip() {
    do-compress "7z" $1
}

function dorar() {
    do-compress "rar" $1
}

function en7z() {
    encrypt-compress "7z" $1
}

function en7zip() {
    encrypt-compress "7z" $1
}

function enzip() {
    encrypt-compress "zip" $1
}

function enrar() {
    encrypt-compress "rar" $1
}

function mk() {
    if [[ -z $1 ]]; then
        echo "Enter a directory name"
    elif [[ -d $1 ]]; then
        echo "\`$1' already exists"
        cd $1
    else
        mkdir -v $1 && cd $1 && pwd
    fi
}

function mktouch() {
    if [[ $# -lt 1 ]]; then
        echo "Missing argument"
        return 1
    fi

    for f in "$@"; do
        mkdir -p -- "$(dirname -- "$f")"
        touch -- "$f"
    done
}

function yml2csv() {
    cat $1 | perl -pe 's/:\n//g' | sed -e 's/  - /,/g'
}

function shebang() {
    if i=$(which $1); then
        printf '#!/usr/bin/env %s\n\n' $1 >$2 && chmod 755 $2 && $EDITOR $2 && chmod 755 $2
    else
        echo "'which' could not find $1, is it in your \$PATH?"
    fi
    # in case the new script is in path, this throw out the command hash table and
    # start over  (man zshbuiltins)
    rehash
}

function etb() {
    l=$(tar tf $1)
    if [ $(echo "$l" | wc -l) -eq $(echo "$l" | grep $(echo "$l" | head -n1) | wc -l) ]; then
        tar xf $1
    else
        mkdir ${1%.t(ar.gz||ar.bz2||gz||bz||ar)} && tar xvf $1 -C ${1%.t(ar.gz||ar.bz2||gz||bz||ar)}
    fi
}

function man() {
    env \
        LESS_TERMCAP_mb=$'\e[01;31m' \
        LESS_TERMCAP_md=$'\e[01;31m' \
        LESS_TERMCAP_me=$'\e[0m' \
        LESS_TERMCAP_se=$'\e[0m' \
        LESS_TERMCAP_so=$'\e[01;44;33m' \
        LESS_TERMCAP_ue=$'\e[0m' \
        LESS_TERMCAP_us=$'\e[01;32m' \
        man "$@"
}

# Put a console clock in top right corner
# http://www.commandlinefu.com/commands/view/7916/
function clock() {
    while sleep 1; do
        tput sc
        tput cup 0 $(($(tput cols) - 29))
        date "+%Y-%m-%d %H:%M:%S %z"
        tput rc
    done &
}

function run-with-sudo() {
    LBUFFER="sudo $LBUFFER"
}
zle -N run-with-sudo
bindkey '^Xs' run-with-sudo
