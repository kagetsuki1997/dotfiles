# Dotfiles

## Nix Flake Usage

Update `nix-flake`

```bash
$ nix flake update
```

Update a single `nix-flake` `input`

```bash
$ nix flake lock --update-input <input-name>
```

Update `nix-flake` and create a Git commit

```bash
$ nix flake update --commit-lock-file --commit-lockfile-summary 'chore(nix): update `flake.lock`'
```

## NixOS Configurations

- [axrytxnf](./nixos/hosts/axrytxnf)
- [bnxotsci](./nixos/hosts/bnxotsci)
- [vapmiehc](./nixos/hosts/vapmiehc)
- [xapekcim](./nixos/hosts/xapekcim)

Build the configuration with default profile

```bash
$ nixos-rebuild build --flake .
```

Build the configuration with specified profile (eg. `axrytxnf`)

```bash
$ nixos-rebuild build --flake '.#axrytxnf'
```

Switch the configuration with default profile

```bash
$ nixos-rebuild --use-remote-sudo switch --flake .
```

Switch the configuration with specified profile (eg. `axrytxnf`)

```bash
$ nixos-rebuild --use-remote-sudo switch --flake '.#axrytxnf'
```

## Home Manager Configurations

- [axrytxnf](./home/hosts/axrytxnf)
- [bnxotsci](./home/hosts/bnxotsci)
- [vapmiehc](./home/hosts/vapmiehc)
- [xapekcim](./home/hosts/xapekcim)

Build the configuration with default profile

```bash
$ nix run '.#hm-build'
```

Build the configuration with specified profile (eg. `axrytxnf`)

```bash
$ nix run '.#hm-build' 'user@axrytxnf'
```

Build and activate the configuration

```bash
$ nix run '.#hm-switch'
```

Build and activate the configuration with specified profile (eg. `axrytxnf`)

```bash
$ nix run '.#hm-switch' 'user@axrytxnf'
```

## Images

### ISO image

```bash
$ nix build '.#images.iso' # generate image
$ dd if=./result/iso/nixos.iso of=/dev/sdX status=progress # copy ISO to USB flash drive
```

### `qemu-kvm` runner

```bash
$ nix build '.#images.vm' # generate image
$ ./result/bin/run-nixos-vm # start virtual machine
```

### VirtualBox image

```bash
$ nix build '.#images.virtualbox' # generate image
$ ls ./result/*.ova # show OVA file
```

## SSH Profiles

Setup SSH profile manually

```bash
$ ./ssh/setup.sh
```

Setup SSH profile with `axdot`

```bash
$ axdot apply -r
```

## References

- [Lenivaya's dotfiles](https://github.com/Lenivaya/dotfiles)
- [Mic92's dotfiles](https://github.com/Mic92/dotfiles/)
- [Vonfry's dotfiles](https://github.com/Vonfry/dotfiles)
- [aaronjanse's dotfiles](https://github.com/aaronjanse/dotfiles)
- [bobby285271's dotfiles](https://github.com/bobby285271/nixos-config/)
- [dnordstrom's dotfiles](https://github.com/dnordstrom/dotfiles)
- [ihebchagra's dotfiles](https://github.com/ihebchagra/dotfiles)
- [nprindle's Nix files](https://github.com/nprindle/nixfiles)
- [poscat0x04's dotfiles](https://github.com/poscat0x04/nixos-configuration)
- [ryantm's dotfiles](https://github.com/ryantm/dotfiles)
- [yrashk's dotfiles](https://github.com/yrashk/nix-home)
