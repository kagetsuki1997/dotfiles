final: prev:

with prev;
{
  extra = recurseIntoAttrs {
    apple-fonts = callPackage ./pkgs/data/fonts/apple { };
    monaco-nerd-fonts = callPackage ./pkgs/data/fonts/monaco-nerd { };
    dyna-fonts = callPackages ./pkgs/data/fonts/dyna { inherit prev; };
    microsoft-fonts = callPackage ./pkgs/data/fonts/microsoft { };

    # firefox-launcher = callPackage ./pkgs/tools/networking/firefox-launcher { };
  };
}
