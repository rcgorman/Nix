{
  description = "Ryan's multi-host Determinate Nix, nix-darwin, and Home Manager config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";

    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/3";

    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

  };

  outputs =
    inputs@{
      nixpkgs,
      determinate,
      nix-darwin,
      home-manager,
      nix-homebrew,
      ...
    }:
    let
      username = "ryan";
      domain = "gormantech.com";

      mkDarwinHost =
        {
          flakeHost,
          shortHost,
          prettyName,
          hostPlatform ? "aarch64-darwin",
        }:
        nix-darwin.lib.darwinSystem {
          specialArgs = {
            inherit
              inputs
              username
              domain
              flakeHost
              shortHost
              prettyName
              hostPlatform
              ;

            fqdn = "${shortHost}.${domain}";
          };

          modules = [
            determinate.darwinModules.default

            ./hosts/${flakeHost}

            home-manager.darwinModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "before-home-manager";
                extraSpecialArgs = {
                  inherit username domain flakeHost shortHost prettyName;
                  fqdn = "${shortHost}.${domain}";
                };
                users.${username} = import ./hosts/${flakeHost}/home.nix;
              };
            }

            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                enable = true;
                user = username;
                enableRosetta = false;
                mutableTaps = true;
              };
            }

            {
              homebrew.taps = [
                { name = "homebrew/homebrew-core"; trusted = true; }
                { name = "homebrew/homebrew-cask"; trusted = true; }
                { name = "netbirdio/tap"; trusted = true; }
              ];
            }
          ];
        };
    in
    {
      darwinConfigurations = {
        nixvm = mkDarwinHost {
          flakeHost = "nixvm";
          shortHost = "nixvm";
          prettyName = "Ryan's Nix VM";
          hostPlatform = "aarch64-darwin";
        };

        rg-m4air = mkDarwinHost {
          flakeHost = "rg-m4air";
          shortHost = "rg-m4air";
          prettyName = "Ryan's ";
          hostPlatform = "aarch64-darwin";
        };
      };
    };
}
