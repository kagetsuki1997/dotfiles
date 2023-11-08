{ lib, pkgs, ... }: {

  # Use the systemd-boot EFI boot loader.
  # boot = {
  #   loader = {
  #     systemd-boot = {
  #       enable = true;
  #       memtest86.enable = true;
  #     };

  #     timeout = 3;
  #     efi.canTouchEfiVariables = true;
  #   };

  #   tmpOnTmpfs = true;
  #   initrd.supportedFilesystems = [ "f2fs" ];
  # };

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  boot.initrd.checkJournalingFS = false;
}
