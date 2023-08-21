{ ... }:

{

  # Setup hyprland 
  wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      recommendedEnvironment = true;
  };

  # # Setup Cashix so there's no need to rebuild hyprland.
  # nix.settings = {
  #     substituters = ["https://hyprland.cachix.org"];
  #     trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  # };
}
