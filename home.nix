{ config, pkgs, inputs, ... }:

let
  # Initialize the patched nixpkgs
  patchedPkgs = import inputs.nixpkgs-patched {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
in
{
  imports = [
    ./modules/browser
    ./modules/git
    ./modules/java
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
  home.file."scripts" = {
    source = ./scripts;
    recursive = true;
  };
  home.file.".config/systemd/user/hyprland-session.target".text = ''
    [Unit]
    Description=Hyprland compositor session
    Documentation=man:systemd.special(7)
    BindsTo=graphical-session.target
    Wants=graphical-session-pre.target
    Before=graphical-session.target
  '';

  home.packages = [
    # Util & Core
    pkgs.fastfetch
    pkgs.btop
    pkgs.playerctl
    pkgs.kitty
    pkgs.waybar
    pkgs.hyprpaper
    pkgs.hyprcursor
    pkgs.hyprshot
    pkgs.hyprpicker
    pkgs.hyprsunset
    pkgs.wofi
    pkgs.swaynotificationcenter
    pkgs.libnotify
    pkgs.lm_sensors
    pkgs.brightnessctl
    pkgs.tree
    pkgs.direnv

    # Applications
    pkgs.nautilus
    pkgs.file-roller
    pkgs.eog
    pkgs.vlc
    pkgs.discord
    pkgs.spotify
    pkgs.keepassxc
    pkgs.postman

    # Themes
    pkgs.adwaita-qt
    pkgs.adwaita-qt6

    # IDE's
    pkgs.jetbrains.idea
    pkgs.jetbrains.rider
    # pkgs.jetbrains.clion
    patchedPkgs.jetbrains.clion
    pkgs.jetbrains.webstorm

    # Python
    pkgs.python314
    pkgs.uv

    # C#
    pkgs.dotnet-sdk_10

    # C / C++
    pkgs.cmake
    pkgs.gcc
    pkgs.gdb
    pkgs.ninja
    pkgs.gnumake
    pkgs.valgrind

    # Node
    pkgs.nodejs_26

    # Java
    pkgs.maven
    pkgs.gradle_9
  ];

  home.pointerCursor = {
    enable = true;
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
    gtk4.theme = null;
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style.name = "adwaita-dark";
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
