{ config, pkgs, hostName, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./network-manager.nix

    ../../common.nix
    ../../desktop.nix
    ../../virtualisation.nix
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
      device = "/dev/disk/by-uuid/00000000-c010-4aa4-903e-000000000000";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/0000-0000";
      fsType = "vfat";
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/00000000-c6f9-410e-a614-000000000000";
      fsType = "ext4";
    };

    "/home" = {
      device = "/dev/disk/by-uuid/00000000-0000-0000-0000-000000000000";
      fsType = "ext4";
    };
  };

  services.udev = {
    extraRules = ''
      ### rename network devices
      SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="f0:31:91:00:00:00", NAME="eth0"
      SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="f0:10:67:00:00:00", NAME="wlan0"
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
