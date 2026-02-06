{ pkgs, lib, config, ... }:

{
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [
        "Noto Serif"
        "DejaVu Serif"
      ];
      sansSerif = [
        "Noto Sans"
        "DejaVu Sans"
      ];
      monospace = [
        "JetBrainsMonoNL Nerd Font Mono"
        "DejaVu Sans Mono"
      ];
    };
  };
}
