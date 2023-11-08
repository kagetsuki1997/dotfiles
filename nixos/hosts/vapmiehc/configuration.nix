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

  # Use the systemd-boot EFI boot loader.
  boot = {
    kernelPackages = pkgs.linuxPackages_6_0;
    kernelParams = [ "hid_apple.fnmode=2" "hid_apple.iso_layout=0" ];
    extraModulePackages = [ ];
  };

  hardware = {
    cpu.intel.updateMicrocode = true;
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
  };

  powerManagement.enable = true;

  networking = {
    inherit hostName;
    networkmanager.enable = true;
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/00000000-9925-41c4-b7d6-000000000000";
      fsType = "f2fs";
      options = [ "rw,noatime,nodiratime,discard" ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/0000-0000";
      fsType = "vfat";
      options = [
        "rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro"
      ];
    };

    "/home" = {
      device = "/dev/disk/by-uuid/00000000-0000-0000-0000-000000000000";
      fsType = "f2fs";
      options = [ "rw,noatime,nodiratime,discard" ];
    };
  };

  services.udev = {
    extraRules = ''
      ### rename network devices
      SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="00:00:00:00:00:00", NAME="eth0"
      SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="00:00:00:00:00:00", NAME="eth0"
      SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="00:00:00:00:00:00", NAME="wlan0"

      ### disable wake from S3 on XHC1
      SUBSYSTEM=="pci", KERNEL=="0000:00:14.0", ATTR{power/wakeup}="disabled"
      SUBSYSTEM=="pci", KERNEL=="0000:03:00.0", ATTR{power/wakeup}="disabled"
    '';
  };

  services.xserver = {
    dpi = 160;
    libinput = {
      enable = true;
      touchpad = {
        accelSpeed = "0.35";
        naturalScrolling = false;
        disableWhileTyping = true;
        scrollMethod = "twofinger";
        tapping = false;
      };
    };
  };

  services.acpid = { enable = true; };

  services.mbpfan = {
    enable = true;
    verbose = true;
    settings.general = {
      minFanSpeed = 3000;
      maxFanSpeed = 6150;
      lowTemp = 55;
      highTemp = 60;
    };
  };

  services.tlp = { enable = true; };

  services.logind.extraConfig = ''
    RuntimeDirectorySize=20%
    HandleLidSwitch=suspend
    HandlePowerKey=suspend
  '';

  environment = {
    systemPackages =
      (import ../../packages/base.nix) { inherit pkgs; }
      ++ (import ../../packages/macbook-pro.nix) { inherit pkgs; }
      ++ (with pkgs; [ ]);
  };

  # Enable valo for controlling keyboard backlight and screen backlight
  programs.valo.enable = true;

  # Enable aria2 but don't automatically start it.
  services.aria2-user = {
    enable = true;
    autoStart = false;
  };
}
