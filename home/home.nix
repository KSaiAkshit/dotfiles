{ config, pkgs, ... }:

{
  home.username = "akira";
  home.homeDirectory = "/home/akira";

  targets.genericLinux.enable = true;

  # WARN DO not change
  home.stateVersion = "23.11";

  home.packages = import ./packages.nix pkgs;

  home.file = import ./files.nix ;
  
  home.sessionVariables = {
    EDITOR = "/usr/bin/helix";
  };

  programs.home-manager.enable = true;
}
