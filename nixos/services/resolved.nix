{ config, lib, pkgs, ... }:

{
  services.resolved = {
    enable = true;
    llmnr = "false";
    dnssec = "false";
    extraConfig = ''
      Cache=yes
      DNSOverTLS=opportunistic
    '';
  };
}
