{ config, lib, pkgs, ... }:

{
  containers.tor = {
    autoStart = false;

    config = {
      boot.isContainer = true;
      networking = { hostName = "tor-container"; };

      services.tor = {
        enable = true;
        client.enable = true;
      };
    };
  };
}
