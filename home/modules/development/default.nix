{ pkgs
# , fenix
, withIDEs
, ...
}:

let
  common = with pkgs; [
    binutils
    man-pages
    patchelf
    tokei
    onefetch

    nodePackages.yaml-language-server
    nodePackages.vim-language-server
  ];

  versionControl = with pkgs; [
    git
    gitAndTools.git-extras
    gitAndTools.git-open
    gitAndTools.gitflow
    gitAndTools.hub
    tig
    gitui

    convco
  ];

  benchmarking = with pkgs; [
    drill
    hyperfine
  ];

  buildSystems = with pkgs; [ cmake gnumake ];

  nix = with pkgs; [
    niv

    nix-prefetch-git
    nix-prefetch-docker
    nixpkgs-review
    nixpkgs-fmt
    rnix-lsp
  ];

  assemblers = with pkgs; [ nasm ];

  cfamily = with pkgs; [
    gcc

    clang-analyzer
    clang-tools

    gdb
    lldb
    valgrind
  ];

  rust = with pkgs; [
    (fenix.stable.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
    ])
    (fenix.default.withComponents [
      "rustfmt"
    ])

    rust-bindgen
    rust-analyzer-nightly

    cargo-asm
    cargo-audit
    cargo-bloat
    cargo-cache
    cargo-edit
    cargo-expand
    cargo-make
    cargo-nextest
    cargo-outdated
    cargo-sweep
    cargo-tarpaulin
    cargo-udeps
    cargo-watch
    cargo-workspaces
    cargo-xbuild

    sccache
  ];

  golang = with pkgs; [
    go
    gopls
    golint

    go2nix
  ];

  webdev = with pkgs; [
    nodejs_latest
    yarn

    nodePackages.serve

    nodePackages.prettier
    nodePackages.tern
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
  ];

  python = with pkgs; [ python2 python3 ];

  java = with pkgs; [ openjdk ];

  shell = with pkgs; [
    shfmt

    nodePackages.bash-language-server
  ];

  sql = with pkgs; [
    sqls
  ];

  container = with pkgs; [
    # Docker
    docker-machine
    docker-machine-kvm
    docker-compose

    nodePackages.dockerfile-language-server-nodejs

    # Kubernetes
    kubectl
    kubectx
    kubernetes-helm
    kustomize
    kind
    k9s

    # OpenShift
    # minishift
  ];

  cloudAdmin = with pkgs; [
    awscli
    aws-iam-authenticator
    eksctl
    # bluemix-cli
  ];

  ethereum = with pkgs; [ ethabi solc ];

  firmware = with pkgs; [ ];

  ide = with pkgs; [
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        rust-lang.rust-analyzer
        jnoortheen.nix-ide
        shardulm94.trailing-spaces
        tamasfe.even-better-toml
      ]
      ++ vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "change-case";
          publisher = "wmaurer";
          version = "1.0.0";
          sha256 = "b4dfe3946d8fcee882784469810bdda83a1add482b51a33b7ca1efe8a16aba37";
        }
      ]
      ++ vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "Go";
          publisher = "golang";
          version = "0.39.1";
          sha256 = "8006930a605fc8f33976d43a1d28f5b9e5ba388b9cecde72942b44a7c3d1484e";
        }
      ];
    })

    insomnia
    jetbrains.datagrip
  ];

  lua = with pkgs; [
    lua5_4
    sumneko-lua-language-server
    stylua
  ];

  misc = with pkgs; [
    terraform-ls
    nodePackages.vscode-langservers-extracted
    nodePackages.mermaid-cli
  ];

  yamlFormat = pkgs.formats.yaml { };
in
{
  config = {
    home.packages =
      common
      ++ benchmarking
      ++ versionControl
      ++ buildSystems
      ++ shell
      ++ assemblers
      ++ cfamily
      ++ rust
      ++ golang
      ++ sql
      ++ webdev
      ++ nix
      ++ java
      ++ python
      ++ lua
      ++ container
      ++ cloudAdmin
      ++ misc
      ++ (if withIDEs then ide else [ ])
    ;

    home.file = {
      ".cargo/config".source = ./config/cargo/config;
      ".octaverc".source = ./config/octave/octaverc;

      ".local/bin/rustup-setup".source = ./bin/rust/setup;
      ".local/bin/cargo-mv-target".source = ./bin/rust/cargo-mv-target;
      ".local/bin/cargo-tmpfs-target".source = ./bin/rust/cargo-tmpfs-target;
    };

    xdg.configFile = {
      # "sccache/config".source = ./config/sccache/config;
      # "gh/hosts.yml".source = yamlFormat.generate "gh-hosts.yaml" {
      #   "github.com" = {
      #     "oauth_token" = sops.secrets.github_token;
      #   };
      # };

      "rustfmt/rustfmt.toml".source = ./config/rustfmt.toml;
      "stylua/stylua.toml".source = ./config/stylua.toml;
    };

    programs = {
      gh = {
        enable = true;
        settings = {
          git_protocol = "https";
          prompt = "enabled";
          aliases = {
            co = "pr checkout";
            pc = "pr create";
            pv = "pr view";
          };
          pager = "bat";
        };
      };
    };

  };
}
