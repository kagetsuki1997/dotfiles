{ ... }:

{

  networking.extraHosts = ''
    ### Local services ###
    127.96.0.1           onion.local
    127.96.0.2           fst-network.tunnel.local
    127.96.0.3           nccu-r420.tunnel.local
    127.96.0.4           nccu-nix-builder.tunnel.local

  '';
}
