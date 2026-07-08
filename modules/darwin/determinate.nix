{
  # Determinate owns the Nix installation and daemon.
  # Do not also manage Nix through nix-darwin's nix.* module.
  determinateNix.enable = true;
  nix.enable = false;
}
