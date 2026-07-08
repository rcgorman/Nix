# Ryan's multi-host Nix config

This refactors the previous single-host config into a multi-host layout that can grow into NixOS VMs later.

Shared behavior now lives in reusable profiles:

- `profiles/darwin/workstation.nix` for the common nix-darwin stack
- `profiles/home/workstation.nix` for the common Home Manager stack

Each host file is now a thin override point, so host-specific changes can be added without duplicating the shared imports.

## Hosts

### `nixvm`

- Flake target: `nixvm`
- FQDN / HostName: `nixvm.gormantech.com`
- LocalHostName: `nixvm`
- ComputerName / pretty name: `Ryan's Nix VM`

### `rg-m4air`

- Flake target: `rg-m4air`
- FQDN / HostName: `rg-m4air.gormantech.com`
- LocalHostName: `rg-m4air`
- ComputerName / pretty name: `Ryan's M4`

## First activation

From inside the repo:

```bash
sudo nix run github:nix-darwin/nix-darwin/nix-darwin-26.05#darwin-rebuild -- switch --flake .#nixvm
```

or for the real Mac:

```bash
sudo nix run github:nix-darwin/nix-darwin/nix-darwin-26.05#darwin-rebuild -- switch --flake .#rg-m4air
```

## Normal rebuilds afterward

On the VM:

```bash
sudo darwin-rebuild switch --flake ~/.config/nix-darwin#nixvm
```

On the real Mac:

```bash
sudo darwin-rebuild switch --flake ~/.config/nix-darwin#rg-m4air
```

The `rebuild` shell alias is host-aware because it uses the `flakeHost` passed into Home Manager.

## Layout

```text
flake.nix
hosts/
  nixvm/
    default.nix
    home.nix
  rg-m4air/
    default.nix
    home.nix
modules/
  shared/
    cli.nix
  darwin/
    base.nix
    determinate.nix
    defaults.nix
    fonts.nix
    homebrew.nix
    networking-cli.nix
  home/
    zsh.nix
    git.nix
    starship.nix
    atuin.nix
    zoxide.nix
    fzf.nix
    fastfetch.nix
    yazi.nix
profiles/
  darwin/
    workstation.nix
  home/
    workstation.nix
assets/
  nix-apple-logo.png
  nix_apple_logo_ascii.txt
  devil_platypus_nix_ascii.txt
```

## Determinate Nix

This uses the supported Determinate pattern:

```nix
determinateNix.enable = true;
nix.enable = false;
```

If you hit the `/etc/nix/nix.custom.conf` conflict during activation:

```bash
sudo mv /etc/nix/nix.custom.conf /etc/nix/nix.custom.conf.before-nix-darwin
```

Then rerun the activation command.
