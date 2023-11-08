{ config, lib, pkgs, ... }: {
  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fontconfig = {
      enable = true;
      includeUserConf = true;
      defaultFonts = {
        monospace = [
          "WenQuanYi Micro Hei Mono"
          "文泉驛等寬微米黑"
          "Noto Sans Mono CJK TC"
          "Font Awesome 5 Free Regular"
          "Font Awesome 5 Free Solid"
          "Font Awesome 5 Brands Regular"
        ];

        sansSerif = [
          "WenQuanYi Micro Hei"
          "文泉驛微米黑"
          "Noto Sans CJK TC"
          "Font Awesome 5 Free Regular"
          "Font Awesome 5 Free Solid"
          "Font Awesome 5 Brands Regular"
        ];

        serif = [
          "WenQuanYi Micro Hei"
          "文泉驛微米黑"
          "Noto Sans CJK TC"
          "Font Awesome 5 Free Regular"
          "Font Awesome 5 Free Solid"
          "Font Awesome 5 Brands Regular"
        ];
      };
    };

    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk

      wqy-microhei
      wqy_zenhei

      source-han-sans
      source-han-serif

      corefonts
      inconsolata
      unifont

      terminus_font
      terminus_font_ttf

      anonymousPro
      source-code-pro
      meslo-lg

      fira
      fira-code
      fira-mono
      fira-code-symbols

      siji
      font-awesome_5
      symbola

      powerline-fonts

      extra.apple-fonts
      extra.monaco-nerd-fonts
      cns11643-fonts
      cwtex-q-fonts
      # extra.dyna-fonts.dfheilight-b5
      # extra.dyna-fonts.dfheimedium-b5
      ionicons
      extra.microsoft-fonts
      vistafonts
      vistafonts-chs
      vistafonts-cht
    ];
  };
}
