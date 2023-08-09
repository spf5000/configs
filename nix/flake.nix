{
  description = "My system configuration flake";

  inputs = {
      nixpkgs.url = "nixpkgs/release-23.05";
      home-manager = {
          url = "home-manager/release-23.05";
          inputs.nixpkgs.follows = "nixpkgs";
      };
      hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, home-manager, hyprland }: 
  let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
          inherit system;
          config = {
              allowUnfree = true;
          };
      };
  in
  {
      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
         specialArgs = { inherit system; };
         modules = [ ./system/configuration.nix ];
      };

      homeConfigurations.sean = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
              hyprland.homeManagerModules.default
              ./home/sean/home.nix
          ];
      };
  };
}
