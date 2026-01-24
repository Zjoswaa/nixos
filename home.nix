{ config, pkgs, ... }:

{
  imports = [
    ./modules/browser
    ./modules/git
    ./modules/shell
  ];

  home.username = "joshua";
  home.homeDirectory = "/home/joshua";
  home.stateVersion = "25.11";

  home.file.".config/hypr".source = ./config/hypr;
  home.file.".config/kitty".source = ./config/kitty;
  home.file.".config/wofi".source = ./config/wofi;

  home.packages = [
    pkgs.discord
    pkgs.keepassxc
    pkgs.kdePackages.dolphin
    pkgs.nerd-fonts.jetbrains-mono
  ];

  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 12;
  };
}
