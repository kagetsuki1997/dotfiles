{ config, ... }:

{
  config.programs.git = {
    enable = true;

    userName = "kagetsuki1997";
    userEmail = "kagetsuki1997@users.noreply.github.com";

    # signing = {
    #   key = "0000000000000000";
    #   signByDefault = true;
    # };

    extraConfig = {
      init = {
        defaultBranch = "main";
      };

      core = {
        pager = "delta";
        askPass = "";
      };


      interactive = {
        diffFilter = "delta --color-only";
      };

      add = {
        interactive = {
          useBuiltin = false; # required for git 2.37.0
        };
      };

      delta = {
        navigate = true; # use n and N to move between diff sections
        light = false; # set to true if you're in a terminal w/ a light background color (e.g. the default macOS terminal)
        side-by-side = true;
      };

      merge = {
        conflictstyle = "diff3";
      };

      diff = {
        colorMoved = "default";
      };

      pull = {
        ff = "only";
      };
    };

    aliases = {
      br = "branch";
      ca = "commit --amend";
      ci = "commit";
      co = "checkout";
      fa = "fetch-all";
      fetch-all = "fetch --all --prune";
      fp = "push --force";
      last = "log -1 HEAD";
      ll = "log --oneline --graph";
      ls = "ls-files";
      p = "push";
      rc = "rebase --continue";
      st = "status";
      unstage = "reset HEAD --";
    };
  };
}
