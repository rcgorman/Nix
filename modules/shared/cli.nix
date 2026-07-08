{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Core utilities
    curl
    wget
    unzip
    zip
    tree
    rsync
    openssh
    gnupg

    # Better daily CLI tools
    bat
    eza
    fd
    fzf
    ripgrep
    jq
    yq-go
    btop

    # Shell helpers
    starship
    zoxide
    atuin

    # Git
    git
    gh
    delta

    # Nix helpers
    nil
    nixfmt

    # Infra / secrets / backups
    age
    sops
    ansible
    opentofu
    restic

    # Editor
    neovim
  ];
}
