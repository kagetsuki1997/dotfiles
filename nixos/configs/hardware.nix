{ config, options, lib, pkgs, modulesPath, ... }: {
  hardware = {
    opengl.driSupport32Bit = true;
    pulseaudio = {
      enable = false;
      # daemon.config = { flat-volumes = "no"; };
      # package = pkgs.pulseaudioFull;
    };
  };
}
