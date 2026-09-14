{
  description = "NixOS configuration with zapret-discord-youtube and home-manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    zapret-discord-youtube.url = "github:kartavkun/zapret-discord-youtube";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, zapret-discord-youtube, home-manager, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        zapret-discord-youtube.nixosModules.withTestTools
        home-manager.nixosModules.home-manager
        ./configuration.nix
      ];
    };
  };
}
