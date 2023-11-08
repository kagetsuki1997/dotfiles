{ config, lib, pkgs, ... }: {
  programs = {
    command-not-found.enable = false;

    ssh = {
      startAgent = true;
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      interactiveShellInit = ''
        source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
      '';
    };

    bash = {
      interactiveShellInit = ''
        source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
      '';
    };

    adb.enable = true;

    iotop.enable = true;
    iftop.enable = true;

    mtr.enable = true;

    usbtop.enable = true;
  };
}
