{
  description = "My system configuration flake";

  inputs = {
      # Nix packages. Used for system and home-manager
      nixpkgs.url = "nixpkgs/nixos-23.11";
      nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

      # Home Manager <3
      home-manager = {
          url = "home-manager/release-23.11";
          inputs.nixpkgs.follows = "nixpkgs";
      };

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
      nixgl, 
      firefox-extensions 
  }@inputs : 

  let
      system = "x86_64-linux";
      config = { allowUnfree = true; };
  in
  {
      nixosConfigurations.system = nixpkgs.lib.nixosSystem {
         specialArgs = { 
             inherit system; 
             inherit inputs;
         };
         modules = [ 
             ./modules/configuration.nix 
         ];
      };

      homeConfigurations.home = home-manager.lib.homeManagerConfiguration {
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
              };
          };

          modules = [
              ../modules/home/home.nix
          ];
      };
  };
}
