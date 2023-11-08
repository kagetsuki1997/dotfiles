{ config, lib, pkgs, ... }: {
  environment.shellAliases = {
    l = "ls -l ";
    ll = "ls -l ";
    la = "ls -lA ";
    lr = "ls -R ";

    cd = " cd";
    ".." = " cd ..; ls";
    "..." = " cd ..; cd ..; ls";
    "...." = " cd ..; cd ..; cd ..; ls";
    "cd.." = "..";
    "cd..." = "...";
    "cd...." = "....";

    now = ''date "+%Y-%m-%d %H:%M:%S %z" '';

    rdsk = "cd $HOME/ramdisk";

    vim = "nvim ";
  };
}
