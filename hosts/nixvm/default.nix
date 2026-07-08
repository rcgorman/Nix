{ username, shortHost, fqdn, prettyName, hostPlatform, ... }:

{
  imports = [
    ../../profiles/darwin/workstation.nix
  ];

  nixpkgs.hostPlatform = hostPlatform;
  nixpkgs.config.allowUnfree = true;

  system.primaryUser = username;
  users.users.${username}.home = "/Users/${username}";

  networking.hostName = fqdn;
  networking.localHostName = shortHost;
  networking.computerName = prettyName;

  system.stateVersion = 7;
}
