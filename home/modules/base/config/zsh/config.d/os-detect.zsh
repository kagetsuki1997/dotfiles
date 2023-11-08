if type uname >/dev/null 2>&1; then
    KERNEL=$(uname -s | tr "[:upper:]" "[:lower:]")
else
    echo "uname not found, failed to detect operating system."
    return
fi

# How can I get distribution name and version number in a simple shell script?
# https://unix.stackexchange.com/questions/6345/how-can-i-get-distribution-name-and-version-number-in-a-simple-shell-script

if [[ $KERNEL == "linux" ]]; then
    if [[ -f /etc/os-release ]]; then
        # freedesktop.org and systemd
        . /etc/os-release
        LINUX_DISTRO=$NAME
        LINUX_DISTRO_VERSION=$VERSION_ID

        unset NAME
        unset ID
        unset VERSION
        unset VERSION_CODENAME
        unset VERSION_ID
        unset PRETTY_NAME
        unset HOME_URL
        unset SUPPORT_URL
        unset BUG_REPORT_URL

    elif type lsb_release >/dev/null 2>&1; then
        # linuxbase.org
        LINUX_DISTRO=$(lsb_release -si)
        LINUX_DISTRO_VERSION=$(lsb_release -sr)
    elif [[ -f /etc/lsb-release ]]; then
        # For some versions of Debian/Ubuntu without lsb_release command
        . /etc/lsb-release
        LINUX_DISTRO=$DISTRIB_ID
        LINUX_DISTRO_VERSION=$DISTRIB_RELEASE

        unset DISTRIB_ID
        unset DISTRIB_RELEASE
        unset DISTRIB_CODENAME
        unset DISTRIB_DESCRIPTION

    elif [[ -f /etc/debian_version ]]; then
        # Older Debian/Ubuntu/etc.
        LINUX_DISTRO=Debian
        LINUX_DISTRO_VERSION=$(cat /etc/debian_version)
    elif [[ -f /etc/SuSe-release ]]; then
        # Older SuSE/etc.
    elif [[ -f /etc/redhat-release ]]; then
        # Older Red Hat, CentOS, etc.
    else
        # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
        LINUX_DISTRO=$(uname -s)
        LINUX_DISTRO_VERSION=$(uname -r)
    fi
fi
