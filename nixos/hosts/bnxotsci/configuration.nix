{ config, pkgs, hostName, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./network-manager.nix

    ../../common.nix
    ../../desktop.nix
    ../../virtualisation.nix
    ../../vpn/fstnetwork.nix
  ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        ControllerMode = "dual";
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking = {
    inherit hostName;
    networkmanager.enable = true;
  };

  fileSystems = {

    "/" = {
      device = "/dev/disk/by-uuid/bfecf251-6d16-4fe9-b0e7-000000000000";
      fsType = "f2fs";
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/bd23becc-91ee-4c51-8cd6-000000000000";
      fsType = "f2fs";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/0000-0000";
      fsType = "vfat";
      options = [
        "rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro"
      ];
    };
  };

  services.udev = {
    extraRules = ''
      ### rename network devices
      SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="94:00:00:00:00:00", NAME="eth0"
      SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="f8:00:00:00:00:00", NAME="wlan0"
    '';
  };

  services.fwupd.enable = true;

  environment = {
    systemPackages = (import ../../packages/base.nix) { pkgs = pkgs; }
      ++ (with pkgs; [ bluez ]);
  };

  # Enable aria2 and automatically start it.
  services.aria2-user = {
    enable = true;
    autoStart = true;
  };
}
