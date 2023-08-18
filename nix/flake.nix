{
  description = "My system configuration flake";

  inputs = {
      # Nix packages. Used for system and home-manager
      nixpkgs.url = "nixpkgs/nixos-23.05";
      nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

      # Home Manager <3
      home-manager = {
          url = "home-manager/release-23.05";
          inputs.nixpkgs.follows = "nixpkgs";
      };

      # Hyprland Tiling Window Manager
      hyprland.url = "github:hyprwm/Hyprland";

      # nixGL so we can run nix graphical applications on non-NixOS (Linux) systems
      nixgl.url = "github:guibou/nixGL";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, hyprland, nixgl }@inputs : 
  let
      system = "x86_64-linux";
  in
  {
      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
         specialArgs = { inherit system; };
         modules = [ ./system/configuration.nix ];
      };

      homeConfigurations.sean = home-manager.lib.homeManagerConfiguration {
          # Using unstable packages so nixGL will build with the latest mesa drivers.
          pkgs = import nixpkgs-unstable {
          # pkgs = import nixpkgs {
              inherit system;
              config = {
                  allowUnfree = true;
              };
              # nixGL overlay
              overlays = [ 
                  nixgl.overlay
              ];
          };

         extraSpecialArgs = inputs;

          modules = [
              hyprland.homeManagerModules.default
              # ./home/sean/home.nix {_module.args = { inherit inputs; };}
              ./home/sean/home.nix
          ];
      };
  };
}
