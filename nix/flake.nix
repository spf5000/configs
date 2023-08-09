{
  description = "My system configuration flake";

  inputs = {
      # Nix packages. Used for system and home-manager
      nixpkgs.url = "nixpkgs/release-23.05";

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

  outputs = { self, nixpkgs, home-manager, hyprland, nixgl }: 
  let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
          inherit system;
          config = {
              allowUnfree = true;
          };
          # nixGL overlay
          overlays = [ nixgl.overlay ];
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
