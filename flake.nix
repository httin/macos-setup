{
  description = "macOS setup";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-25.11-darwin";
    };
    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
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
        ];
        inputs = { inherit nixpkgs darwin home-manager; };
      };
      "C02FR17BMD6N" = darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [
          ./configuration.nix
          home-manager.darwinModules.home-manager
          ./hosts/C02FR17BMD6N.nix
        ];
        inputs = { inherit nixpkgs darwin home-manager; };
      };
      "test" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./configuration.nix
          home-manager.darwinModules.home-manager
          ./hosts/test.nix
        ];
        inputs = { inherit nixpkgs darwin home-manager; };
      };
    };
  };
}
