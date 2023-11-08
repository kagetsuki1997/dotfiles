{ pkgs }:

with pkgs; [
  firefox
  nixpkgs-fmt

  efivar
  efibootmgr

  dmidecode
  iw
  lshw
  pciutils
  sysfsutils
  usbutils

  gparted
  gptfdisk
  hdparm
  parted
  smartmontools

  exa
  just

  (hiPrio procps)
  psmisc

  htop
  iftop
  powertop

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
  hexedit
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
    ];
  })

  lhasa
  _7zz
  unrar
  unzip
  zip

  direnv
  nix-zsh-completions
  ranger
  joshuto
  screen
  sourceHighlight
  tmux
  zsh
  zsh-autosuggestions
  zsh-syntax-highlighting
  nix-index

  expect

  bind

  ripgrep

  curl
  wget

  powerline-go

  fzf
]
