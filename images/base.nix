{ config, pkgs, overlays, home-manager, hostName, ... }:

{
  nixpkgs.overlays = overlays;

  imports =
    [
      (import "${home-manager}/nixos")

      ../nixos/configs/fonts.nix
      ../nixos/configs/hardware.nix
      ../nixos/configs/i18n.nix
      ../nixos/configs/programs.nix
      ../nixos/configs/shellAliases.nix
      ../nixos/configs/users.nix

      ../nixos/services/resolved.nix
      ../nixos/services/timesyncd.nix
      ../nixos/services/nix.nix
    ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        ControllerMode = "dual";
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking = {
    inherit hostName;
    networkmanager.enable = true;
    nameservers = [
      "1.1.1.1" # Cloudflare DNS
      "1.0.0.1" # Cloudflare DNS
      "8.8.4.4" # Google DNS
      "8.8.8.8" # Google DNS
      "9.9.9.9" # IBM DNS
      "208.67.222.222" # OpenDNS
      "208.67.220.220" # OpenDNS
      # "168.95.1.1"          # HiNet DNS
      # "168.95.192.1"        # HiNet DNS
    ];
  };

  time = {
    timeZone = "Asia/Taipei";
    hardwareClockInLocalTime = false;
  };

  console = {
    keyMap = "us";
    font = "Lat2-Terminus16";
  };

  services.nscd = {
    enable = true;
    enableNsncd = true;
  };

  services.udisks2.enable = true;

  services.xserver = {
    enable = true;

    desktopManager.xterm.enable = false;
    displayManager.sddm = {
      enable = true;
      autoNumlock = true;
      theme = "abstractdark";
      settings = {
        Theme = {
          ThemeDir = "${pkgs.sddm-themes.abstractdark}/share/sddm/themes";
        };
      };
    };

    windowManager = {
      i3 = {
        enable = true;
        package = pkgs.i3;
        extraPackages = [ ];
      };

      leftwm.enable = true;
    };
  };

  programs.dconf.enable = true;

  environment = {
    systemPackages =
      (import ../nixos/packages/base.nix) { inherit pkgs; } ++
      (import ../nixos/packages/macbook-pro.nix) { inherit pkgs; };
  };

  home-manager = {
    extraSpecialArgs = {
      enableRemoteNixBuilders = false;
      enableHiDPI = false;
      withBrowsers = true;
      withMultimedia = true;
      withGraphics = false;
      withMobile = false;
      withDownloaders = true;
      withTor = true;
      withNetworkBenchmarks = true;
      withIDEs = false;
      withVirtualisationGUISupports = false;
      screenlayoutScript = (builtins.readFile ../home/modules/desktop/config/screenlayout/default.sh);
    };

    users = {
      user = {
        home = {
          username = "user";
          homeDirectory = "/home/kagetsuki";
          stateVersion = "23.05";
        };

        imports = [
          ../home/modules/base
          ../home/modules/networking
          ../home/modules/desktop
        ];

        nixpkgs = {
          inherit overlays;
          config = {
            allowUnfree = true;
            oraclejdk.accept_license = true;
          };
        };
      };
    };

  };
}
