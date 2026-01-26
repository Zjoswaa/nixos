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

  #home.file.".config/hypr/hyprland.conf".source = ./config/hypr/hyprland.conf;
  #home.file.".config/hypr/hyprpaper.conf".source = ./config/hypr/hyprpaper.conf;
  #home.file.".config/kitty/kitty.conf".source = ./config/kitty/kitty.conf;
  #home.file.".config/wofi/config".source = ./config/wofi/config;
  #home.file.".config/wofi/style.css".source = ./config/wofi/style.css;
  #home.file.".config/waybar/config.jsonc".source = ./config/waybar/config.jsonc;
  #home.file.".config/waybar/style.css".source = ./config/waybar/style.css;
  home.file.".config/hypr" = {
    source = ./config/hypr;
    recursive = true;
  };
  home.file.".config/kitty" = {
    source = ./config/kitty;
    recursive = true;
  };
  home.file.".config/wofi" = {
    source = ./config/wofi;
    recursive = true;
  };
  home.file.".config/waybar" = {
    source = ./config/waybar;
    recursive = true;
  };

  home.packages = [
    pkgs.discord
    pkgs.spotify
    pkgs.keepassxc
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.python314
  ];

  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 16;
  };
}
