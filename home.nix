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

  home.sessionVariables = {
    EDITOR = "code";
    VISUAL = "code";
  };

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
    pkgs.vscode-fhs
  ];

  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 16;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/plain" = [ "code.desktop" ];
    };
  };
}
