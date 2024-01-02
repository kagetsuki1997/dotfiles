{ pkgs
, withBrowsers
, withMultimedia
, withGraphics
, withMobile
, screenlayoutScript
, enableHiDPI
, ...
}:

{
  imports = [
    ./config/fcitx.nix
    ./config/gtk.nix
  ];

  config = {
    home.file.".xprofile".source = ./config/xprofile;

    xresources.properties = {
      "Xft.antialias" = true;
      "Xft.autohint" = 0;
      "Xft.hinting" = true;
      "Xft.hintstyle" = "hintfull";
      "Xft.lcdfilter" = "lcddefault";
      "Xft.rgba" = "rgb";

      "*background" = "#000000";
      "*foreground" = "#174af0";
    }
    // (if enableHiDPI then { "Xft.dpi" = 128; } else { });

    home.pointerCursor = {
      x11.enable = true;
      name = "Paper";
      size = if enableHiDPI then 48 else 16;
      package = pkgs.paper-icon-theme;
    };

    xdg.configFile = {
      # "i3/config".source = ./config/i3/config;
      # "i3/scripts/autorun".source = ./config/i3/scripts/autorun;
      # "i3/scripts/screenshot".source = ./config/i3/scripts/screenshot;
      # "i3/scripts/set-wallpaper".source = ./config/i3/scripts/set-wallpaper;
      # "i3/scripts/toggle-touchpad".source = ./config/i3/scripts/toggle-touchpad;

      # "leftwm/config.ron".source = ./config/leftwm/config.ron;
      # "leftwm/scripts/screenshot".source = ./config/leftwm/scripts/screenshot;
      # "leftwm/scripts/set-wallpaper".source = ./config/leftwm/scripts/set-wallpaper;
      # "leftwm/themes/current" = {
      #   source = ./config/leftwm/themes/default;
      #   recursive = true;
      # };

      # "rofi/config.rasi".source = ./config/rofi/config.rasi;
      # "polybar".source = ./config/polybar;
      # "picom.conf".source = ./config/picom/picom.conf;
      # "screenlayout/default.sh" = {
      #   executable = true;
      #   text = screenlayoutScript;
      # };

      "fcitx5/config".source = ./config/fcitx5/config;
      "fcitx5/profile".source = ./config/fcitx5/profile;
      "fcitx5/conf/classicui.conf".source =
        if enableHiDPI then
          ./config/fcitx5/conf/classicui-hidpi.conf
        else ./config/fcitx5/conf/classicui.conf;
      "fcitx5/conf/chewing.conf".source = ./config/fcitx5/conf/chewing.conf;
      "fcitx5/conf/chttrans.conf".source = ./config/fcitx5/conf/chttrans.conf;
      "fcitx5/conf/mozc.conf".source = ./config/fcitx5/conf/mozc.conf;
      "fcitx5/conf/hangul.conf".source = ./config/fcitx5/conf/hangul.conf;
      "fcitx5/conf/rime.conf".source = ./config/fcitx5/conf/rime.conf;

      "clipcat/clipcat-menu.toml".source = ./config/clipcat/clipcat-menu.toml;
      "clipcat/clipcatctl.toml".source = ./config/clipcat/clipcatctl.toml;
      "clipcat/clipcatd.toml".source = ./config/clipcat/clipcatd.toml;

      "firefox-user.js".source = ./config/firefox/default-user.js;

      "mpv/mpv.conf".source = ./config/mpv/mpv.conf;
      "mpd/mpd.conf".source = ./config/mpd/mpd.conf;
      "cantata/cantata.conf".text = builtins.readFile ./config/cantata/cantata.conf;

      "pcmanfm/default/pcmanfm.conf".source = ./config/pcmanfm/default/pcmanfm.conf;

      "qt5ct/qt5ct.conf".source = ./config/qt5ct/qt5ct.conf;
    };

    xdg.dataFile = {
      "fcitx5/rime" = {
        source = with pkgs;
          runCommand "fcitx-rime-data" { } ''
            mkdir -p $out
            cp -r ${pkgs.rime-data}/share/rime-data/* $out
            cp ${./config/rime/default.custom.yaml} $out/default.custom.yaml
          '';
        recursive = true;
      };

      "fcitx5/themes/Material-Color/theme.conf".source = "${pkgs.fcitx5-themes.material-color}/theme-indigo.conf";
      "fcitx5/themes/thep0y-autumn" = {
        source = "${pkgs.fcitx5-themes.thep0y}/autumn";
        recursive = true;
      };
      "fcitx5/themes/thep0y-green" = {
        source = "${pkgs.fcitx5-themes.thep0y}/green";
        recursive = true;
      };
      "fcitx5/themes/thep0y-spring" = {
        source = "${pkgs.fcitx5-themes.thep0y}/spring";
        recursive = true;
      };
      "fcitx5/themes/thep0y-transparent-green" = {
        source = "${pkgs.fcitx5-themes.thep0y}/transparent-green";
        recursive = true;
      };
      "fcitx5/themes/thep0y-winter" = {
        source = "${pkgs.fcitx5-themes.thep0y}/winter";
        recursive = true;
      };
      "fcitx5/themes/nord-dark" = {
        source = "${pkgs.fcitx5-themes.nord}/Nord-Dark";
        recursive = true;
      };

      "wallpapers/default.png".source = "${pkgs.desktop-wallpapers.fedora-28.zen}";
    };

    programs = {
      alacritty = {
        enable = true;
        settings = import ./config/alacritty.nix { inherit enableHiDPI; };
      };
    } // (
      if withBrowsers then {
        chromium = {
          enable = true;

          commandLineArgs =
            if enableHiDPI then [
              "--add-flags --force-device-scale-factor=1.5"
            ] else [ ];

          extensions = [
            "cekfddagaicikmgoheekchngpadahmlf" # Google search link fix
            "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
            "clngdbkpkpeebahjckkjfobafhncgmne" # Stylus
            "dbepggeogbaibhgnhhndojpepiihcmeb" # Vimium
            "djflhoibgkdhkhhcedjiklpkjnoahfmg" # User-Agent Switcher for Chrome
            "fhcgjolkccmbidfldomjliifgaodjagh" # Cookie AutoDelete
            "hnoonkgmmnklbdehoepdjcidhjbncjmi" # Yet Another Drag and Go
            "kbmfpngjjgdllneeigpgjifpgocmfgmb" # Reddit Enhancement Suite
            "khpcanbeojalbkpgpmjpdkjnkfcgfkhb" # Chromium Wheel Smooth Scroller
            "mgijmajocgfcbeboacabfgobmjgjcoja" # Google Dictionary (by Google)
            "padekgcemlokbadohgkifijomclgjgif" # Proxy SwitchyOmega
          ];
        };
      }
      else { }
    );

    home.packages = with pkgs; [
      arandr
      xorg.xhost
      xorg.xkill

      clipcat
      xclip

      # notify-osd
      # libnotify

      # feh
      # picom
      # polybar
      # rofi
      # slock

      # scrot
      # maim

      # pavucontrol
      # ponymix

      # rdesktop

      # evince
      # pcmanfm
      # qimgv

      # shared-mime-info
      # gtk-engine-murrine

      # adwaita-qt
      # arc-icon-theme
      # arc-theme
      # hicolor-icon-theme
      # paper-icon-theme
      # qt5ct

      font-manager

      # for previewing image while using ranger
      python3Packages.ueberzug
    ]
    ++ (if withBrowsers then
      (
        let
          browsers =
            if enableHiDPI then
              with pkgs.extra; [ firefox-hidpi ]
            else
              with pkgs; [ firefox ];

          common = with pkgs; [
            # extra.firefox-launcher
            profile-cleaner
          ];

        in
        browsers ++ common
      ) else [ ])
    ++ (if withMultimedia then with pkgs; [
      ffmpeg
      imagemagick
      transcode

      mpv

      # handbrake
      mkvtoolnix
      playerctl

      cantata
      mpc_cli
      mpd
      ncmpcpp
    ] else [ ])
    ++ (if withGraphics then with pkgs; [ drawio ] else [ ])
    ++ (if withMobile then with pkgs; [ scrcpy ] else [ ]);
  };
}
