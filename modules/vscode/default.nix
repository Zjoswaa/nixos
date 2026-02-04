{ pkgs, lib, config, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode-fhs;

    profiles = {
      default = {
        extensions = with pkgs.vscode-extensions; [
          pkief.material-icon-theme
          dracula-theme.theme-dracula
          bbenoist.nix
          ms-vscode.cpptools
          ms-python.python
          editorconfig.editorconfig
        ];
        userSettings = {
          "editor.fontSize" = 16;
          "editor.fontFamily" = "'JetBrainsMonoNL Nerd Font Mono', 'Droid Sans Mono', 'monospace', monospace";
          "workbench.colorTheme" = "Dracula Theme";
          "workbench.iconTheme" = "material-icon-theme";
          "window.zoomLevel" = 0;
          "workbench.activityBar.location" = "hidden";
          "workbench.editor.showTabs" = "multiple";
          "editor.minimap.enabled" = false;
          "workbench.startupEditor" = "none";
          "workbench.tips.enabled" = false;
          "breadcrumbs.enabled" = false;
          "material-icon-theme.hidesExplorerArrows" = false;
          "workbench.tree.enableStickyScroll" = false;
          "workbench.tree.renderIndentGuides" = "always";
          "workbench.tree.indent" = 16;
          "explorer.compactFolders" = false;
          "explorer.confirmDragAndDrop" = false;
          "explorer.confirmDelete" = false;
          "explorer.decorations.badges" = false;
          "window.titleBarStyle" = "custom";
          "editor.cursorBlinking" = "phase";
          "terminal.integrated.defaultProfile.linux" = "fish";
          "extensions.ignoreRecommendations" = true;
          "terminal.integrated.initialHint" = false;
          "git.confirmSync" = false;
        };
      };
    };
  };
}
