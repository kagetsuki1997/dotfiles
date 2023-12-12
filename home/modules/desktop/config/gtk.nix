{ config, pkgs, ... }:

{
  config.dconf.enable = true;

  config.gtk = {
    enable = true;

    font.name = "Noto Sans 11";

    iconTheme = {
      package = pkgs.paper-icon-theme;
      name = "Paper";
    };

    theme = {
      package = pkgs.arc-theme;
      name = "Arc-Darker";
    };

    gtk2 = {
      extraConfig = ''
        gtk-toolbar-style=GTK_TOOLBAR_BOTH
        gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
        gtk-button-images=1
        gtk-menu-images=1
        gtk-enable-event-sounds=1
        gtk-enable-input-feedback-sounds=1
        gtk-xft-antialias=1
        gtk-xft-hinting=1
        gtk-xft-hintstyle="hintfull"
        gtk-xft-rgba="rgb"
      '';
    };

    gtk3 = {
      extraConfig = {
        gtk-toolbar-style = "GTK_TOOLBAR_BOTH";
        gtk-toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR";
        gtk-button-images = 1;
        gtk-menu-images = 1;
        gtk-enable-event-sounds = 1;
        gtk-enable-input-feedback-sounds = 1;
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintfull";
        gtk-xft-rgba = "rgb";
      };

      bookmarks = [
        "file:///home/kagetsuki Home"
        "file:///home/kagetsuki/Downloads Downloads"
        # "file:///home/kagetsuki/sources sources"
        "file:///home/kagetsuki/dotfiles dotfiles"
        # "file:///home/kagetsuki/scripts scripts"
        # "file:///home/kagetsuki/projects projects"
        # "file:///home/kagetsuki/Music Music"
        # "file:///home/kagetsuki/git git"
        # "file:///home/kagetsuki/screenshots"
      ];
    };
  };
}
