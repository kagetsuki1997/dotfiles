{ lib, config, pkgs, ... }:

{
  services.xserver = {
    enable = true;

    desktopManager.xterm.enable = false;
    displayManager.sddm.enable = true;

    # Enable KDE
    desktopManager.plasma5.enable = true;


    # windowManager = {
    #   i3 = {
    #     enable = true;
    #     package = pkgs.i3;
    #     extraPackages = [ ];
    #   };

    #   leftwm.enable = true;
    # };
  };

  programs.slock-customized.enable = true;

  programs.dconf.enable = true;
}
