{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.tanex;
in
{
  options = {

    services.tanex = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Whether or not to enable Tanex";
      };
    };

  };

  config = mkIf cfg.enable {

    systemd.user.services.tanex = {
      description = "RAMDisk";
      wantedBy = [ "default.target" ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = "yes";
        ExecStart = "${pkgs.extra.tanex}/bin/tanex create-all";
      };
    };

  };
}
