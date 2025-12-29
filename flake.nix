{
  description = "Tin's macOS setup";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-24.11";
    };
    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager }: {
    darwinConfigurations = {
      "AS-J4X9R649X4" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./configuration.nix
          home-manager.darwinModules.home-manager
          ./hosts/AS-J4X9R649X4.nix
          ({ pkgs, ... }: {
            nixpkgs.config.allowUnfree = true;
          })
          ({ pkgs, ... }: {
            nixpkgs.overlays = [
              (self: super: {
                karabiner-elements = super.karabiner-elements.overrideAttrs (old: {
                  version = "14.13.0";
                  src = super.fetchurl {
                    inherit (old.src) url;
                    hash = "sha256-gmJwoht/Tfm5qMecmq1N6PSAIfWOqsvuHU8VDJY8bLw=";
                  };
                });
              })
            ];
          })
        ];
        inputs = { inherit nixpkgs darwin home-manager; };
      };
    };
  };
}
