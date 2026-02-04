{ config, pkgs, ... }:

{
  imports = [
    ./modules/browser
    ./modules/git
    ./modules/shell
    ./modules/vscode
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
    pkgs.neofetch
    pkgs.playerctl
    pkgs.kitty
    pkgs.waybar
    pkgs.hyprpaper
    pkgs.hyprcursor
    pkgs.hyprshot
    pkgs.wofi
    pkgs.swaynotificationcenter
    pkgs.nautilus
    pkgs.file-roller
    pkgs.eog
    pkgs.vlc
    pkgs.discord
    pkgs.spotify
    pkgs.keepassxc
    pkgs.python314
    pkgs.gcc
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
      "text/markdown" = [ "code.desktop" ];
      "text/html" = [ "firefox.desktop" ];

      "application/pdf" = [ "firefox.desktop" ];

      "image/png" = [ "eog.desktop" ];
      "image/jpeg" = [ "eog.desktop" ];
      "image/gif" = [ "eog.desktop" ];
      "image/bmp" = [ "eog.desktop" ];

      "audio/mpeg" = [ "vlc.desktop" ];
      "audio/ogg" = [ "vlc.desktop" ];

      "video/mp4" = [ "vlc.desktop" ];
      "video/x-matroska" = [ "vlc.desktop" ];

      "application/zip" = [ "file-roller.desktop" ];
      "application/x-tar" = [ "file-roller.desktop" ];
      "application/x-gzip" = [ "file-roller.desktop" ];
    };
  };
}
