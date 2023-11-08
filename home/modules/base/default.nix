{ pkgs
, enableRemoteNixBuilders
, ...
}:

{
  imports = [
    ./config/bat.nix
    ./config/git.nix
    ./config/htop.nix

    ./config/default-apps.nix
  ];

  config = {
    home.file = {
      ".bashrc".source = ./config/bash/bashrc;
      ".zshrc".source = ./config/zsh/zshrc;

      ".curlrc".source = ./config/curl/curlrc;
      ".wgetrc".source = ./config/wget/wgetrc;

      ".tmux.conf".source = ./config/tmux/tmux.conf;

      ".local/bin/nvim-setup".source = ./config/nvim/setup.sh;
    };

    xdg.configFile = {
      "nix/nix.conf".text =
        builtins.readFile
          (
            # if enableRemoteNixBuilders then ./config/nix/nix.conf
            # else ./config/nix/fallback-nix.conf
            ./config/nix/fallback-nix.conf
          );
      # +
      # ''
      #   access-token = github.com=${sops.secrets.github_token}
      # '';
      "nix/fallback-nix.conf".text = builtins.readFile ./config/nix/fallback-nix.conf;
      # +
      # ''
      #   access-token = github.com=${sops.secrets.github_token}
      # '';

      "bash".source = ./config/bash;
      "zsh".source = ./config/zsh;
      "starship.toml".source = ./config/starship/starship.toml;

      "direnv".source = ./config/direnv;
      "eriksync/eriksync.yaml".source = ./config/eriksync/eriksync.yaml;

      "neofetch/config.conf".source = ./config/neofetch/config.conf;

      "nvim/init.lua".source = ./config/nvim/init.lua;
      "nvim/lua".source = ./config/nvim/lua;
      "nvim/snippets".source = ./config/nvim/snippets;

      "procs/config.toml".source = ./config/procs/config.toml;

      "ranger/rc.conf".source = ./config/ranger/rc.conf;
      "ranger/rifle.conf".source = ./config/ranger/rifle.conf;
      "ranger/scope.sh".source = ./config/ranger/scope.sh;

      # "tanex/default.yaml".source = ./config/tanex/default.yaml;
      # "tunka/default.yaml".source = ./config/tunka/default.yaml;

      "Code" = {
        source = ./config/Code;
        recursive = true;
      };
    };

    programs = {
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };

    services.gpg-agent = {
      enable = true;
      pinentryFlavor = "curses";
      defaultCacheTtl = 864000;
      defaultCacheTtlSsh = 864000;
      maxCacheTtl = 864000;
      maxCacheTtlSsh = 864000;
    };

    home.packages = with pkgs; [
      efivar
      efibootmgr

      dmidecode
      iw
      lshw
      pciutils
      sysfsutils
      usbutils
      wavemon

      gparted
      gptfdisk
      hdparm
      parted
      smartmontools

      exa
      just
      procs

      (hiPrio procps)
      psmisc

      htop
      powertop
      bottom
      # kmon

      lsof
      lm_sensors
      nethogs
      vnstat

      fuseiso
      f2fs-tools
      exfat
      ntfs3g
      go-mtpfs
      archivemount
      libarchive

      neovim
      tree-sitter

      hexedit

      lhasa
      _7zz
      unrar
      unzip
      zip

      nix-zsh-completions
      ranger
      screen
      sourceHighlight
      tmux
      zsh
      zsh-autosuggestions
      zsh-syntax-highlighting
      starship

      expect

      mtr
      bind
      fping

      ripgrep
      delta

      curl
      wget

      gnupg

      powerline-go

      fzf
      skim

      # extra.tanex
      # extra.tunka

      neofetch

      bat
      dos2unix
      fd
      file
      jq
      mkpasswd
      du-dust
      ncdu
      opencc
      openssl
      tree

      tealdeer
      pal

      vimv-rs

      xenon
      axdot
      eriksync
    ];
  };
}
