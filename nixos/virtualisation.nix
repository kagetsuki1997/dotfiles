{ pkgs, ... }:

{
  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = false;
      liveRestore = false;
      package = pkgs.docker;
      daemon.settings = {
        features = {
          buildkit = true;
        };
      };
    };

    # virtualbox = {
    #   host = {
    #     enable = true;
    #     enableExtensionPack = true;
    #   };
    # };

    libvirtd = { enable = true; };

    # support USB redirection
    spiceUSBRedirection.enable = true;
  };

  systemd.sockets.libvirtd-tcp.enable = false;
}
