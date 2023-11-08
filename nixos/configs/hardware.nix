{ config, options, lib, pkgs, modulesPath, ... }: {
  hardware = {
    opengl.driSupport32Bit = true;
    pulseaudio = {
      enable = true;
      daemon.config = { flat-volumes = "no"; };
      package = pkgs.pulseaudioFull;
    };
  };
}
