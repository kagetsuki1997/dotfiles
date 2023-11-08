{ config, lib, pkgs, ... }:

{
  networking.firewall = {
    enable = true;
    allowPing = false;
    allowedTCPPorts = [ 22 8080 ];
    allowedUDPPorts = [ ];
    extraPackages = [ pkgs.ipset ];
    extraCommands = builtins.readFile ./firewall.rules;
  };
}

