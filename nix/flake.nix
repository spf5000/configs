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

      # Firefox extensions
      firefox-extensions = {
          url = "gitlab:rycee/nur-expressions/?dir=pkgs/firefox-addons";
          inputs.nixpkgs.follows = "nixpkgs";
      };
  };

  outputs = { 
      self, 
      nixpkgs, 
      nixpkgs-unstable, 
      home-manager, 
      hyprland, 
      nixgl, 
      firefox-extensions 
  }@inputs : 

  let
      system = "x86_64-linux";
      config = { allowUnfree = true; };
  in
  {
      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
         specialArgs = { 
             inherit system; 
             inherit inputs;
         };
         modules = [ 
             ./system/configuration.nix 
         ];
      };

      homeConfigurations.sean = home-manager.lib.homeManagerConfiguration {
          # Setting default pkgs to stable (23.05) nix.
          pkgs = import nixpkgs {
              config = config;
          };


          # Pass unstable nix packages for nixGL with latest drivers and access to other unstable packages.
          extraSpecialArgs = {
              inherit inputs;

              pkgs-unstable = import nixpkgs-unstable {
                  inherit system;
                  config = config;

                  # nixGL overlay. Part of stable for the latest mesa drivers.
                  overlays = [ 
                      nixgl.overlay
                  ];
              };
          };

          modules = [
              hyprland.homeManagerModules.default
              ./home/sean/home.nix
          ];
      };
  };
}
