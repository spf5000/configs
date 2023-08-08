{
  description = "My system configuration flake";

  inputs = {
      nixpkgs.url = "nixpkgs/release-23.05";
  };

  outputs = { self, nixpkgs }: 
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
         modules = [ ./configuration.nix ];
      };
  };
}
