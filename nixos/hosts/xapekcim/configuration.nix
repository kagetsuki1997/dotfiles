{ config, pkgs, secrets, hostName, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./network-manager.nix

    ../../common.nix
    ../../desktop.nix
    ../../virtualisation.nix

    ../../vpn/fstnetwork.nix
  ];

  hardware = {
    cpu.amd.updateMicrocode = true;

    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = { General = { ControllerMode = "bredr"; }; };
    };

    nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking = {
    inherit hostName;
    networkmanager.enable = true;
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/00000000-39fd-46f8-9f56-000000000000";
      fsType = "f2fs";
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/00000000-e234-44f3-acb6-000000000000";
      fsType = "f2fs";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/0000-0000";
      fsType = "vfat";
    };

    "/home" = {
      device = "/dev/disk/by-uuid/00000000-ca1f-46af-af2d-000000000000";
      fsType = "f2fs";
    };

    "/DATA" = {
      device = "/dev/disk/by-uuid/00000000-3227-4c99-8b49-000000000000";
      fsType = "ext4";
      options = [ "rw,relatime,data=ordered" ];
    };

    "/DATA2" = {
      device = "/dev/disk/by-uuid/00000000-f336-4776-882e-000000000000";
      fsType = "ext4";
      options = [ "rw,relatime,data=ordered" ];
    };

    "/DATA3" = {
      device = "/dev/disk/by-uuid/00000000-7fa4-4e9c-81f3-000000000000";
      fsType = "ext4";
      options = [ "rw,relatime,data=ordered" ];
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  services.udev = {
    extraRules = ''
      ### rename network devices
      SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="f0:00:00:00:00:00", NAME="eth0"
      SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="64:00:00:00:00:00", NAME="wlan0"
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
    autoStart = false;
  };
}
