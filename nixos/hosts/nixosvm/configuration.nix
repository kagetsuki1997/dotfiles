{ config, pkgs, hostName, ... }:

{
  imports = [
    ./hardware-configuration.nix
    # ./sops.nix

    ../../common.nix
    ../../desktop.nix
    ../../virtualisation.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking = {
    inherit hostName;
    networkmanager.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "kagetsuki";

  environment = {
    systemPackages = (import ../../packages/base.nix) { pkgs = pkgs; }
      ++ (with pkgs; [ bluez ]);
  };

  # Enable aria2 and automatically start it.
  # services.aria2-user = {
  #   enable = true;
  #   autoStart = true;
  # };
}
