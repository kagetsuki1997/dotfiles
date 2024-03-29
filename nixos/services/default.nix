{ pkgs, sops, enableRemoteBuildMachines, ... }:

{
  imports = [
    # ./openssh.nix
    ./resolved.nix
    ./timesyncd.nix
    ./vnstat.nix
    ./nix.nix
  ];

  # services.nscd = {
  #   enable = true;
  #   enableNsncd = true;
  # };

  # services.udisks2.enable = true;

  # Enable tanex for creating ramdisk, cache on tmpfs
  # services.tanex.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "tw";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  # sound.enable = true;
  # security.rtkit.enable = true;
  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   alsa.support32Bit = true;
  #   pulse.enable = true;
  #   # If you want to use JACK applications, uncomment this
  #   #jack.enable = true;

  #   # use the example session manager (no others are packaged yet so this is enabled by default,
  #   # no need to redefine it in your config for now)
  #   #media-session.enable = true;
  # };
}
