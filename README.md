Nix config

## First activation

```bash
sudo nix run github:nix-darwin/nix-darwin/nix-darwin-26.05#darwin-rebuild -- switch --flake .#rg-m4air
```

## Normal rebuilds afterward

```bash
sudo darwin-rebuild switch --flake ~/.config/nix-darwin#rg-m4air
```

or

```bash
rebuild
```

The `rebuild` shell alias is host-aware because it uses the `flakeHost` passed into Home Manager.

## Layout

flake.nix is the top-level assembly layer. It defines the inputs, creates a mkDarwinHost function, and uses that to build named systems.
The function wires together:
host-specific system config from hosts/<name>/default.nix
host-specific Home Manager entrypoint from hosts/<name>/home.nix
shared Darwin/Home Manager infrastructure like nix-homebrew and Home Manager integration

The hosts/ layer is the identity layer.

The profiles/ layer is the composition layer. This is where modules are grouped into a role.

The modules/ layer is the feature layer. Each module should do one focused thing

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
