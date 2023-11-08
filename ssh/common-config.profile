Host *
    ServerAliveInterval 120
    Compression yes
    ControlMaster auto
    ControlPersist yes
    ControlPath "/run/user/%i/ssh_%r@%h:%p"

# vim: set filetype=sshconfig :
