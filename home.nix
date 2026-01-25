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

  home.file.".config/hypr/hyprland.conf".source = ./config/hypr/hyprland.conf;
  home.file.".config/hypr/hyprpaper.conf".source = ./config/hypr/hyprpaper.conf;
  home.file.".config/kitty/kitty.conf".source = ./config/kitty/kitty.conf;
  home.file.".config/wofi/config".source = ./config/wofi/config;
  home.file.".config/wofi/style.css".source = ./config/wofi/style.css;
  home.file.".config/waybar/config.jsonc".source = ./config/waybar/config.jsonc;
  home.file.".config/waybar/style.css".source = ./config/waybar/style.css;

  home.packages = [
    pkgs.discord
    pkgs.keepassxc
    pkgs.kdePackages.dolphin
    pkgs.nerd-fonts.jetbrains-mono
  ];

  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 16;
  };
}
