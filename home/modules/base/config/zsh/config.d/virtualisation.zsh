if type virsh >/dev/null 2>&1; then
    export VIRSH_DEFAULT_CONNECT_URI=qemu:///system
fi
